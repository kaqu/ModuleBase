import Base

internal struct AnyFeatureLoader {

  internal static func unimplemented<Feature>(
    for featureType: Feature.Type = Feature.self
  ) -> Self
  where Feature: AnyFeature {
    .init(
      typeIdentifier: .for(Feature.self),
      load: { _, _, _ throws -> Feature in
        throw FeatureUnimplemented.error
      }
    )
  }

  internal let typeIdentifier: FeatureTypeIdentifier
  internal let load: (
    Features,
    _ state: Any,
    _ context: Any
  ) throws -> AnyFeature
}

extension AnyFeatureLoader: Hashable {

  internal static func == (
    _ lhs: AnyFeatureLoader,
    _ rhs: AnyFeatureLoader
  ) -> Bool {
    lhs.typeIdentifier == rhs.typeIdentifier
  }

  internal func hash(
    into hasher: inout Hasher
  ) {
    hasher.combine(typeIdentifier)
  }
}

public struct FeatureLoader<Feature> where Feature: AnyFeature {

  public static var unimplemented: Self
  { .init() }
  public static func always(_ instance: Feature) -> Self
  { .init(always: instance) }

  internal let loader: AnyFeatureLoader

  private init() {
    self.loader = .unimplemented(for: Feature.self)
  }

  private init(
    always instance: Feature
  ) {
    self.loader = .init(
      typeIdentifier: .for(Feature.self),
      load: { _, _, _ throws -> Feature in
        instance
      }
    )
  }

  internal init(
    from loader: AnyFeatureLoader
  ) {
    precondition(loader.typeIdentifier == .for(Feature.self))
    self.loader = loader
  }

  public init(
    load: @escaping (Features) throws -> Feature
  ) where Feature: StatelessFeature {
    self.loader = .init(
      typeIdentifier: .for(Feature.self),
      load: { features, _, _ throws -> Feature in
        try load(features)
      }
    )
  }

  public init(
    load: @escaping (Features, Feature.Context) throws -> Feature
  ) where Feature: ContextualStatelessFeature {
    self.loader = .init(
      typeIdentifier: .for(Feature.self),
      load: { features, _, context throws -> Feature in
        guard let context: Feature.Context = context as? Feature.Context
        else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
        return try load(features, context)
      }
    )
  }

  public init(
    load: @escaping (Features, Feature.State) throws -> Feature
  ) where Feature: StatefulFeature {
    self.loader = .init(
      typeIdentifier: .for(Feature.self),
      load: { features, state, _ throws -> Feature in
        guard let state: Feature.State = state as? Feature.State
        else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
        return try load(features, state)
      }
    )
  }

  public init(
    load: @escaping (Features, Feature.State, Feature.Context) throws -> Feature
  ) where Feature: ContextualStatefulFeature {
    self.loader = .init(
      typeIdentifier: .for(Feature.self),
      load: { features, state, context throws -> Feature in
        guard
          let state: Feature.State = state as? Feature.State,
          let context: Feature.Context = context as? Feature.Context
        else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
        return try load(features, state, context)
      }
    )
  }

  public func load(
    using features: Features
  ) throws -> Feature where Feature: StatelessFeature {
    guard let feature: Feature = try self.loader.load(features, Void(), Void()) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }

  public func load(
    using features: Features,
    in context: Feature.Context
  ) throws -> Feature where Feature: ContextualStatelessFeature {
    guard let feature: Feature = try self.loader.load(features, Void(), context) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }

  public func load(
    using features: Features,
    in state: Feature.State
  ) throws -> Feature where Feature: StatefulFeature {
    guard let feature: Feature = try self.loader.load(features, state, Void()) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }

  public func load(
    using features: Features,
    in state: Feature.State,
    with context: Feature.Context
  ) throws -> Feature where Feature: ContextualStatefulFeature {
    guard let feature: Feature = try self.loader.load(features, state, context) as? Feature
    else { unreachable("Feature loading type safety is provided by FeaturesRegistry and Features implementation.") }
    return feature
  }
}
