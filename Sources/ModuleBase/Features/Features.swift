import Base

public struct Features<Tag> {

  public let registry: FeaturesRegistry

  internal let instance: (FeatureTypeIdentifier, AnyHashable?) throws -> AnyFeature
  internal let use: (AnyFeature) throws -> Void
  internal let isLoaded: (FeatureTypeIdentifier, AnyHashable?) -> Bool
  private let deinitializer: Deinitializer

  internal init(
    registry: FeaturesRegistry,
    instance: @escaping (FeatureTypeIdentifier, AnyHashable?) throws -> AnyFeature,
    use: @escaping (AnyFeature) throws -> Void,
    isLoaded: @escaping (FeatureTypeIdentifier, AnyHashable?) -> Bool,
    deinitializer: Deinitializer
  ) {
    self.registry = registry
    self.instance = instance
    self.use = use
    self.isLoaded = isLoaded
    self.deinitializer = deinitializer
  }
}

extension Features: AnyFeatures {

  public func instance<Feature>(
    of featureType: Feature.Type = Feature.self
  ) throws -> Feature
  where Feature: ContextlessFeature {
    let feature: AnyFeature = try self.instance(Feature.typeIdentifier, .none)

    if let feature: Feature = feature as? Feature {
      return feature
    }
    else {
      throw InternalInconsistency.error(message: "Invalid type of feature was loaded.")
    }
  }

  public func instance<Feature>(
    of featureType: Feature.Type = Feature.self,
    context: Feature.Context
  ) throws -> Feature
  where Feature: ContextualFeature {
    let feature: AnyFeature = try self.instance(Feature.typeIdentifier, context)

    if let feature: Feature = feature as? Feature {
      return feature
    }
    else {
      throw InternalInconsistency.error(message: "Invalid type of feature was loaded.")
    }
  }

  public func use(
    _ feature: AnyFeature
  ) throws {
    try use(feature)
  }

  public func isLoaded<Feature>(
    _ featureType: Feature.Type
  ) throws -> Bool
  where Feature: ContextlessFeature {
    self.isLoaded(Feature.typeIdentifier, .none)
  }

  public func isLoaded<Feature>(
    _ featureType: Feature.Type,
    context: Feature.Context
  ) throws -> Bool
  where Feature: ContextualFeature {
    self.isLoaded(Feature.typeIdentifier, context)
  }

  public func fork<ForkedTag>(
    using registry: FeaturesRegistry? = .none,
    tag: ForkedTag.Type = ForkedTag.self
  ) -> Features<ForkedTag> {
    Features<ForkedTag>
      .forked(
        from: self,
        using: registry ?? self.registry
      )
  }
}

public struct FeatureConflict: TheError {

  public static func error(
    message: StaticString,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      debugMeta: .info(
        message: message,
        file: file,
        line: line
      )
    )
  }

  public var debugMeta: DebugMeta
}
