// TODO: verify behavior of loading, fallbacks etc.
internal final class ForkedFeatures: Features {

  internal let registry: FeaturesRegistry?
  private let lock: SpinLock = .init()
  private var localFeatures: Dictionary<FeatureInstanceIdentifier, AnyFeature> = .init()
  private let parent: Features

  internal init(
    parent: Features,
    registry: FeaturesRegistry?
  ) {
    self.parent = parent
    self.registry = registry
  }

  internal func instance<Feature>(
    of featureType: Feature.Type
  ) throws -> Feature
  where Feature: StatelessFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextless: featureType)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      return feature
    }
    else if let inheritedFeature: Feature = try? self.parent.instance() {
      return inheritedFeature
    }
    else if let registry: FeaturesRegistry = self.registry {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
    else {
      throw FeatureUnimplemented.error
    }
  }

  internal func instance<Feature>(
    of featureType: Feature.Type,
    in context: Feature.Context
  ) throws -> Feature
  where Feature : ContextualStatelessFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextual: featureType, in: context)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      return feature
    }
    else if let inheritedFeature: Feature = try? self.parent.instance(in: context) {
      return inheritedFeature
    }
    else if let registry: FeaturesRegistry = self.registry {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: context)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
    else {
      throw FeatureUnimplemented.error
    }
  }

  internal func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?
  ) throws -> Feature
  where Feature : StatefulFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextless: featureType)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      if let updatedState: Feature.State = state {
        try feature.override(state: updatedState)
        return feature
      }
      else {
        return feature
      }
    }
    else if let inheritedFeature: Feature = try? self.parent.instance() {
      if let updatedState: Feature.State = state {
        try inheritedFeature.override(state: updatedState)
        return inheritedFeature
      }
      else {
        return inheritedFeature
      }
    }
    else if let registry: FeaturesRegistry = self.registry {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: state ?? .initial())
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
    else {
      throw FeatureUnimplemented.error
    }
  }

  internal func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?,
    with context: Feature.Context
  ) throws -> Feature
  where Feature : ContextualStatefulFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextual: featureType, in: context)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      if let updatedState: Feature.State = state {
        try feature.override(state: updatedState)
        return feature
      }
      else {
        return feature
      }
    }
    else if let inheritedFeature: Feature = try? self.parent.instance(in: state, with: context) {
      if let updatedState: Feature.State = state {
        try inheritedFeature.override(state: updatedState)
        return inheritedFeature
      }
      else {
        return inheritedFeature
      }
    }
    else if let registry: FeaturesRegistry = self.registry {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: state ?? .initial(), with: context)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
    else {
      throw FeatureUnimplemented.error
    }
  }

  internal func fork(
    with registry: FeaturesRegistry?
  ) -> Features {
    ForkedFeatures(
      parent: self,
      registry: registry
    )
  }

  private func feature(
    for identifier: FeatureInstanceIdentifier
  ) -> AnyFeature? {
    self.lock.withLock {
      self.localFeatures[identifier]
    }
  }

  private func updateFeature(
    for identifier: FeatureInstanceIdentifier,
    with feature: AnyFeature
  ) {
    self.lock.withLock {
      self.localFeatures[identifier] = feature
    }
  }
}
