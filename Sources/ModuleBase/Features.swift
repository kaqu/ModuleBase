import Base

public protocol Features {

  func instance<Feature>(
    of featureType: Feature.Type
  ) throws -> Feature
  where Feature: StatelessFeature

  func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?
  ) throws -> Feature
  where Feature: StatefulFeature

  func instance<Feature>(
    of featureType: Feature.Type,
    in context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualStatelessFeature

  func instance<Feature>(
    of featureType: Feature.Type,
    in state: Feature.State?,
    with context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualStatefulFeature

  func fork(with registry: FeaturesRegistry?) -> Features
}

extension Features {

  func instance<Feature>() throws -> Feature
  where Feature: StatelessFeature {
    try instance(of: Feature.self)
  }

  func instance<Feature>(
    in state: Feature.State? = .none
  ) throws -> Feature
  where Feature: StatefulFeature {
    try instance(of: Feature.self, in: state)
  }

  func instance<Feature>(
    in context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualStatelessFeature {
    try instance(of: Feature.self, in: context)
  }

  func instance<Feature>(
    in state: Feature.State? = .none,
    with context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualStatefulFeature {
    try instance(of: Feature.self, in: state, with: context)
  }

  func fork() -> Features {
    self.fork(with: FeaturesRegistry.shared)
  }
}
