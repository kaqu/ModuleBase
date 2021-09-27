public struct FeaturesRegistry {

  private static let lock: SpinLock = .init()
  private static var _shared: Self = .init()
  public static var shared: Self {
    get { Self.lock.withLock { Self._shared } }
    set { Self.lock.withLock { Self._shared = newValue } }
  }

  public static func use<Feature>(
    _ loader: FeatureLoader<Feature>,
    for featureType: Feature.Type
  ) where Feature: AnyFeature {
    Self.shared.use(loader, for: featureType)
  }

  private var registry: Dictionary<FeatureTypeIdentifier, AnyFeatureLoader> = .init()

  public func loader<Feature>(
    for featureType: Feature.Type
  ) -> FeatureLoader<Feature> where Feature: AnyFeature {
    self.registry[.for(featureType)].map(FeatureLoader<Feature>.init(from:))
    ?? .unimplemented
  }

  public mutating func use<Feature>(
    _ loader: FeatureLoader<Feature>,
    for featureType: Feature.Type
  ) where Feature: AnyFeature {
    self.registry[.for(featureType)] = loader.loader
  }
}
