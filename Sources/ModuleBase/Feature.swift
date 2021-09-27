import Base

public protocol AnyFeature {

  func unload(from features: Features) throws
}

extension AnyFeature {

  public func unload(from _: Features) throws {
    throw FeatureUnloadUnavailable.error
  }
}

public protocol AnyContextlessFeature: AnyFeature {}

public protocol AnyContextualFeature: AnyFeature {

  associatedtype Context: Hashable
  var context: Context { get }
}

public protocol StatelessFeature: AnyContextlessFeature {}

public protocol ContextualStatelessFeature: AnyContextualFeature {}

public protocol StatefulFeature: AnyContextlessFeature {

  associatedtype State: FeatureState

  func override(state: State) throws
}

extension StatefulFeature {

  public func override(state: State) throws {
    throw FeatureStateOverrideUnavailable.error
  }
}

public protocol ContextualStatefulFeature: AnyContextualFeature {

  associatedtype State: FeatureState

  func override(state: State) throws
}

extension ContextualStatefulFeature {

  public func override(state: State) throws {
    throw FeatureStateOverrideUnavailable.error
  }
}

public protocol FeatureState {

  static func initial() -> Self
}
