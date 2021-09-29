import Base

public protocol AnyFeatures {

  func instance<Feature>(
    of featureType: Feature.Type
  ) throws -> Feature
  where Feature: ContextlessFeature

  func instance<Feature>(
    of featureType: Feature.Type,
    context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualFeature

  func use(
    _ feature: AnyFeature
  ) throws

  func isLoaded<Feature>(
    _ featureType: Feature.Type
  ) throws -> Bool
  where Feature: ContextlessFeature

  func isLoaded<Feature>(
    _ featureType: Feature.Type,
    context: Feature.Context
  ) throws -> Bool
  where Feature: ContextualFeature

  func fork<Tag>(
    using registry: FeaturesRegistry?,
    tag: Tag.Type
  ) -> Features<Tag>
}

extension AnyFeatures {

  public func instance<Feature>() throws -> Feature
  where Feature: ContextlessFeature {
    try self.instance(of: Feature.self)
  }

  public func instance<Feature>(
    context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualFeature {
    try self.instance(of: Feature.self, context: context)
  }

  public func instanceIfLoaded<Feature>(
    of featureType: Feature.Type = Feature.self
  ) throws -> Feature?
  where Feature: ContextlessFeature {
    if try self.isLoaded(Feature.self) {
      return try self.instance(of: Feature.self)
    }
    else {
      return .none
    }
  }

  public func instanceIfLoaded<Feature>(
    of featureType: Feature.Type = Feature.self,
    context: Feature.Context
  ) throws -> Feature?
  where Feature: ContextualFeature {
    if try self.isLoaded(Feature.self, context: context) {
      return try self.instance(of: Feature.self, context: context)
    }
    else {
      return .none
    }
  }

  public func fork<Tag>(
    tag: Tag.Type
  ) -> Features<Tag> {
    self.fork(using: .none, tag: tag)
  }
}
