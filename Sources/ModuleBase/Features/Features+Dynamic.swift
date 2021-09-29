import Base
import class Foundation.NSRecursiveLock

public typealias DynamicFeatures = Features<Void>

extension DynamicFeatures {

  public static func dynamic(
    using registry: FeaturesRegistry = .shared,
    features: AnyFeature...
  ) -> Self {
    let lock: NSRecursiveLock = .init()
    var features: Dictionary<FeatureInstanceIdentifier, AnyFeature>
    = .init(uniqueKeysWithValues: features.map { ($0.instanceIdentifier, $0) })

    let deinitializer: Deinitializer = .init {
      lock.withLock {
        for (_, feature) in features {
          do {
            if
              let currentlyLoadedFeature: AnyFeature = features[feature.instanceIdentifier],
              let featureUnloader: AnyFeatureUnloader = try registry.getUnloader(feature.instanceIdentifier.typeIdentifier)
            {
              try featureUnloader.unload(currentlyLoadedFeature)
            }
            else {
              /* noop */
            }
          }
          catch let error as TheError {
            error.asFatalError()
          }
          catch {
            Undefined
              .error(
                message: "Features deinitialization failed due to unexpected error"
              )
              .asFatalError()
          }
        }
      }
    }

    func instance(
      of featureTypeIdentifier: FeatureTypeIdentifier,
      context: AnyHashable?
    ) throws -> AnyFeature {
      try lock.withLock {
        let featureInstanceIdentifier: FeatureInstanceIdentifier
        = .identifier(
          for: featureTypeIdentifier,
          context: context
        )
        if let feature: AnyFeature = features[featureInstanceIdentifier] {
          return feature
        }
        else if let featureLoader: AnyFeatureLoader = try registry.getLoader(featureTypeIdentifier) {
          let loadedFeature: AnyFeature
          = try featureLoader
            .load(
              Self(
                registry: registry,
                instance: instance(of:context:),
                use: use(feature:),
                isLoaded: isLoaded(_:context:),
                deinitializer: deinitializer
              ),
              context
            )
          features[featureInstanceIdentifier] = loadedFeature
          return loadedFeature
        }
        else {
          throw FeatureUnimplemented.error(for: featureTypeIdentifier.featureType)
        }
      }
    }

    func use(
      feature: AnyFeature
    ) throws {
      try lock.withLock {
        if
          let currentlyLoadedFeature: AnyFeature = features[feature.instanceIdentifier],
          let featureUnloader: AnyFeatureUnloader = try registry.getUnloader(feature.instanceIdentifier.typeIdentifier)
        {
          try featureUnloader.unload(currentlyLoadedFeature)
        }
        else {
          /* noop */
        }
        features[feature.instanceIdentifier] = feature
      }
    }

    func isLoaded(
      _ featureTypeIdentifier: FeatureTypeIdentifier,
      context: AnyHashable?
    ) -> Bool {
      lock.withLock {
        features
          .keys
          .contains(
            .identifier(
              for: featureTypeIdentifier,
              context: context
            )
          )
      }
    }

    return Self(
      registry: registry,
      instance: instance(of:context:),
      use: use(feature:),
      isLoaded: isLoaded(_:context:),
      deinitializer: deinitializer
    )
  }
}
