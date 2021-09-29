import Base

internal struct AnyFeatureUnloader {

  internal static func unavailable<Feature>(
    for featureType: Feature.Type = Feature.self
  ) -> Self
  where Feature: AnyFeature {
    .init(
      typeIdentifier: Feature.typeIdentifier,
      unload: { feature throws -> Void in
        throw FeatureUnloadUnavailable.error(for: feature.instanceIdentifier.featureType)
      }
    )
  }

  internal static func noop<Feature>(
    for featureType: Feature.Type = Feature.self
  ) -> Self
  where Feature: AnyFeature {
    .init(
      typeIdentifier: Feature.typeIdentifier,
      unload: { _ throws -> Void in
        /* noop */
      }
    )
  }

  internal let typeIdentifier: FeatureTypeIdentifier
  internal let unload: (
    AnyFeature
  ) throws -> Void
}

extension AnyFeatureUnloader: Hashable {

  public static func == (
    _ lhs: AnyFeatureUnloader,
    _ rhs: AnyFeatureUnloader
  ) -> Bool {
    lhs.typeIdentifier == rhs.typeIdentifier
  }

  public func hash(
    into hasher: inout Hasher
  ) {
    hasher.combine(typeIdentifier)
  }
}

public struct FeatureUnloader<Feature> where Feature: AnyFeature {

  public static var unavailable: Self
  { .init(unloader: .unavailable(for: Feature.self)) }

  public static var noop: Self
  { .init(unloader: .noop(for: Feature.self)) }

  internal let unloader: AnyFeatureUnloader

  private init(unloader: AnyFeatureUnloader) {
    self.unloader = unloader
  }

  internal init(
    from unloader: AnyFeatureUnloader
  ) {
    precondition(unloader.typeIdentifier == Feature.typeIdentifier)
    self.unloader = unloader
  }

  public init(
    unload: @escaping (Feature) throws -> Void
  ) {
    self.unloader = .init(
      typeIdentifier: Feature.typeIdentifier,
      unload: { feature throws -> Void in
        guard let feature: Feature = feature as? Feature
        else { unreachable("Feature unloading type safety is provided by FeaturesRegistry and Features implementation.") }
        return try unload(feature)
      }
    )
  }

  public func unload(
    _ feature: Feature
  ) throws {
    try self.unloader.unload(feature)
  }
}

public struct FeatureUnloadUnavailable: TheError {

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
