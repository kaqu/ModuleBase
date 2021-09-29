import Base

internal struct AnyFeatureLoader {

  internal static func unimplemented<Feature>(
    for featureType: Feature.Type = Feature.self
  ) -> Self
  where Feature: AnyFeature {
    .init(
      typeIdentifier: Feature.typeIdentifier,
      load: { _, _ throws -> Feature in
        throw FeatureUnimplemented.error(for: Feature.self)
      }
    )
  }

  internal let typeIdentifier: FeatureTypeIdentifier
  internal let load: (
    AnyFeatures,
    _ context: Any?
  ) throws -> AnyFeature
}

extension AnyFeatureLoader: Hashable {

  public static func == (
    _ lhs: AnyFeatureLoader,
    _ rhs: AnyFeatureLoader
  ) -> Bool {
    lhs.typeIdentifier == rhs.typeIdentifier
  }

  public func hash(
    into hasher: inout Hasher
  ) {
    hasher.combine(typeIdentifier)
  }
}

public struct FeatureLoader<Feature> where Feature: AnyFeature {

  public static var unimplemented: Self
  { .init() }
  public static func always(
    _ instance: Feature
  ) -> Self
  { .init(always: instance) }

  internal let loader: AnyFeatureLoader

  private init() {
    self.loader = .unimplemented(for: Feature.self)
  }

  private init(
    always instance: Feature
  ) {
    self.loader = .init(
      typeIdentifier: Feature.typeIdentifier,
      load: { _, _ throws -> Feature in
        instance
      }
    )
  }

  internal init(
    from loader: AnyFeatureLoader
  ) {
    precondition(loader.typeIdentifier == Feature.typeIdentifier)
    self.loader = loader
  }

  public init(
    load: @escaping (AnyFeatures) throws -> Feature
  ) where Feature: ContextlessFeature {
    self.loader = .init(
      typeIdentifier: Feature.typeIdentifier,
      load: { features, _ throws -> Feature in
        try load(features)
      }
    )
  }

  public init(
    load: @escaping (AnyFeatures, Feature.Context) throws -> Feature
  ) where Feature: ContextualFeature {
    self.loader = .init(
      typeIdentifier: Feature.typeIdentifier,
      load: { features, context throws -> Feature in
        guard let context: Feature.Context = context as? Feature.Context
        else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
        return try load(features, context)
      }
    )
  }

  public func load(
    using features: AnyFeatures
  ) throws -> Feature where Feature: ContextlessFeature {
    guard let feature: Feature = try self.loader.load(features, .none) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }

  public func load(
    using features: AnyFeatures,
    in context: Feature.Context
  ) throws -> Feature where Feature: ContextualFeature {
    guard let feature: Feature = try self.loader.load(features, context) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }
}

public struct FeatureUnimplemented: TheError {

  public static func error(
    for featureType: AnyFeature.Type,
    message: StaticString = "",
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      debugMeta: .info(
        message: message,
        file: file,
        line: line
      ),
      featureType: featureType
    )
  }

  public var debugMeta: DebugMeta
  public let featureType: AnyFeature.Type

  public var debugDescription: String {
    "\(Self.self) - \(featureType) \(self.debugMeta.debugDescription)"
  }
}
