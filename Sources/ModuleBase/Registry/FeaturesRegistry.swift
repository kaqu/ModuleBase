import Base

public struct FeaturesRegistry {

  internal let getLoader: (FeatureTypeIdentifier) throws -> AnyFeatureLoader?
  internal let getUnloader: (FeatureTypeIdentifier) throws -> AnyFeatureUnloader?
  internal let registerFeature: (AnyFeatureLoader, AnyFeatureUnloader) throws -> Void

  private init(
    getLoader: @escaping (FeatureTypeIdentifier) throws -> AnyFeatureLoader?,
    getUnloader: @escaping (FeatureTypeIdentifier) throws -> AnyFeatureUnloader?,
    registerFeature: @escaping (AnyFeatureLoader, AnyFeatureUnloader) throws -> Void
  ) {
    self.getLoader = getLoader
    self.getUnloader = getUnloader
    self.registerFeature = registerFeature
  }
}

extension FeaturesRegistry {

  public func loader<Feature>(
    for featureType: Feature.Type = Feature.self
  ) throws -> FeatureLoader<Feature>?
  where Feature: AnyFeature {
    try self.getLoader(Feature.typeIdentifier)
      .map(FeatureLoader<Feature>.init(from:))
  }

  public func unloader<Feature>(
    for featureType: Feature.Type = Feature.self
  ) throws -> FeatureUnloader<Feature>?
  where Feature: AnyFeature {
    try self.getUnloader(Feature.typeIdentifier)
      .map(FeatureUnloader<Feature>.init(from:))
  }

  public func unloader<Feature>(
    for feature: Feature
  ) throws -> FeatureUnloader<Feature>?
  where Feature: AnyFeature {
    try self.getUnloader(Feature.typeIdentifier)
      .map(FeatureUnloader<Feature>.init(from:))
  }

  public func register<Feature>(
    loader: FeatureLoader<Feature>,
    unloader: FeatureUnloader<Feature> = .unavailable,
    for featureType: Feature.Type = Feature.self
  ) throws where Feature: AnyFeature {
    try self.registerFeature(loader.loader, unloader.unloader)
  }

  public func use<Feature>(
    _ feature: Feature,
    unloader: FeatureUnloader<Feature> = .unavailable
  ) throws where Feature: AnyFeature {
    try self.register(loader: .always(feature), unloader: unloader)
  }
}

extension FeaturesRegistry {

  public static let shared: Self = {
    let lock: SpinLock = .init()
    var registry: Dictionary<FeatureTypeIdentifier, (loader: AnyFeatureLoader, unloader: AnyFeatureUnloader)> = .init()

    return Self(
      getLoader: { featureTypeIdentifier in
        lock.withLock {
          registry[featureTypeIdentifier]?.loader
        }
      },
      getUnloader: { featureTypeIdentifier in
        lock.withLock {
          registry[featureTypeIdentifier]?.unloader
        }
      },
      registerFeature: { featureLoader, featureUnloader in
        lock.withLock {
          registry[featureLoader.typeIdentifier] = (loader: featureLoader, unloader: featureUnloader)
        }
      }
    )
  }()

  public static func use<Feature>(
    loader: FeatureLoader<Feature>,
    unloader: FeatureUnloader<Feature> = .unavailable,
    for featureType: Feature.Type = Feature.self
  ) throws where Feature: AnyFeature {
    try Self.shared.register(loader: loader, unloader: unloader)
  }

  public static func use<Feature>(
    _ feature: Feature,
    unloader: FeatureUnloader<Feature> = .unavailable
  ) throws where Feature: AnyFeature {
    try Self.shared.use(feature, unloader: unloader)
  }
}

extension FeaturesRegistry {

  public static func dynamic() -> Self {
    var registry: Dictionary<FeatureTypeIdentifier, (loader: AnyFeatureLoader, unloader: AnyFeatureUnloader)> = .init()

    return Self(
      getLoader: { featureTypeIdentifier in
        registry[featureTypeIdentifier]?.loader
      },
      getUnloader: { featureTypeIdentifier in
        registry[featureTypeIdentifier]?.unloader
      },
      registerFeature: { featureLoader, featureUnloader in
        registry[featureLoader.typeIdentifier] = (loader: featureLoader, unloader: featureUnloader)
      }
    )
  }
}


public struct FeaturesRegistryMutationUnavailable: TheError {

  public static func error(
    message: StaticString = "",
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
