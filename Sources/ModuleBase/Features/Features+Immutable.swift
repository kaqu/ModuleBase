import Base

public typealias ImmutableFeatures = Features<Never>

extension ImmutableFeatures {

  public static func immutable(
    using registry: FeaturesRegistry = .shared,
    features head: AnyFeature,
    _ tail: AnyFeature...
  ) -> Self {
    let features: Dictionary<FeatureInstanceIdentifier, AnyFeature>
    = .init(uniqueKeysWithValues: ([head] + tail).map { ($0.instanceIdentifier, $0) })

    let deinitializer: Deinitializer = .init {
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

    func instance(
      of featureTypeIdentifier: FeatureTypeIdentifier,
      context: AnyHashable?
    ) throws -> AnyFeature {
      let featureInstanceIdentifier: FeatureInstanceIdentifier
      = .identifier(
        for: featureTypeIdentifier,
        context: context
      )
      if let feature: AnyFeature = features[featureInstanceIdentifier] {
        return feature
      }
      else {
        throw FeatureUnimplemented.error(for: featureTypeIdentifier.featureType)
      }
    }

    func use(
      feature: AnyFeature
    ) throws {
      throw FeaturesMutationUnavailable.error()
    }

    func isLoaded(
      _ featureTypeIdentifier: FeatureTypeIdentifier,
      context: AnyHashable?
    ) -> Bool {
      features
        .keys
        .contains(
          .identifier(
            for: featureTypeIdentifier,
               context: context
          )
        )
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

public struct FeaturesMutationUnavailable: TheError {

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
