public final class LazyFeatures: Features {

  public let registry: FeaturesRegistry
  private let lock: SpinLock = .init()
  private var features: Dictionary<FeatureInstanceIdentifier, AnyFeature> = .init()

  public init(
    using registry: FeaturesRegistry = .shared
  ) {
    self.registry = registry
  }

  public func instance<Feature>(
    of featureType: Feature.Type
  ) throws -> Feature
  where Feature: StatelessFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextless: featureType)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      return feature
    }
    else {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
  }

  public func instance<Feature>(
    of featureType: Feature.Type,
    in context: Feature.Context
  ) throws -> Feature
  where Feature : ContextualStatelessFeature {
    let identifier: FeatureInstanceIdentifier = .for(contextual: featureType, in: context)
    if let feature: Feature = self.feature(for: identifier) as? Feature {
      return feature
    }
    else {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: context)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
  }

  public func instance<Feature>(
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
    else {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: state ?? .initial())
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
  }

  public func instance<Feature>(
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
    else {
      let feature: Feature = try registry
        .loader(for: Feature.self)
        .load(using: self, in: state ?? .initial(), with: context)
      self.updateFeature(for: identifier, with: feature)
      return feature
    }
  }

  public func fork(
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
      self.features[identifier]
    }
  }

  private func updateFeature(
    for identifier: FeatureInstanceIdentifier,
    with feature: AnyFeature
  ) {
    self.lock.withLock {
      self.features[identifier] = feature
    }
  }
}
