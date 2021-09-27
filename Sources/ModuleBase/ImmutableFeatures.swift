// ImmutableFeatures does not unload their features when being dealocated,
// it should be used only as a root. - behaviour to be verified
public struct ImmutableFeatures: Features {

  private let features: Dictionary<FeatureInstanceIdentifier, AnyFeature>

  public init(
    using head: AnyContextlessFeature,
    _ tail: AnyContextlessFeature...
  ) {
    var features: Dictionary<FeatureInstanceIdentifier, AnyFeature> = .init()
    features.reserveCapacity(features.count + 1)
    features[.init(typeIdentifier: .init(identifier: .init(type(of: head))))] = head
    tail.forEach { feature in
      features[.init(typeIdentifier: .init(identifier: .init(type(of: feature))))] = feature
    }
    self.features = features
  }

  public func instance<Feature>(
    of featureType: Feature.Type
  ) throws -> Feature
  where Feature : StatelessFeature {
    if let feature: Feature = self.feature(.for(contextless: featureType)) as? Feature {
      return feature
    }
    else {
      // TODO: verify the error - it might be FeatureUnimplemented error instead
      throw FeatureUnavailable.error
    }
  }

  public func instance<Feature>(
    of featureType: Feature.Type,
    in context: Feature.Context
  ) throws -> Feature
  where Feature : ContextualStatelessFeature {
    if let feature: Feature = self.feature(.for(contextual: featureType, in: context)) as? Feature {
      return feature
    }
    else {
      // TODO: verify the error - it might be FeatureUnimplemented error instead
      throw FeatureUnavailable.error
    }
  }

  public func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?
  ) throws -> Feature
  where Feature : StatefulFeature {
    if let feature: Feature = self.feature(.for(contextless: featureType)) as? Feature {
      if let updatedState: Feature.State = state {
        try feature.override(state: updatedState)
        return feature
      }
      else {
        return feature
      }
    }
    else {
      // TODO: verify the error - it might be FeatureUnimplemented error instead
      throw FeatureUnavailable.error
    }
  }

  public func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?,
    with context: Feature.Context
  ) throws -> Feature
  where Feature : ContextualStatefulFeature {
    if let feature: Feature = self.feature(.for(contextual: featureType, in: context)) as? Feature {
      if let updatedState: Feature.State = state {
        try feature.override(state: updatedState)
        return feature
      }
      else {
        return feature
      }
    }
    else {
      // TODO: verify the error - it might be FeatureUnimplemented error instead
      throw FeatureUnavailable.error
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
    _ identifier: FeatureInstanceIdentifier
  ) -> AnyFeature? {
    self.features[identifier]
  }
}
