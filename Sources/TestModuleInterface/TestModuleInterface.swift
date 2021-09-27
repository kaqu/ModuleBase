import ModuleBase

public struct TestFeatureInterface: StatelessFeature {

  public var doStuff: () -> Void

  public init(
    doStuff: @escaping () -> Void
  ) {
    self.doStuff = doStuff
  }
}

public struct TestStatefulFeatureInterface: StatefulFeature {

  public struct State: FeatureState {

    public static func initial() -> Self {
      .init(
        value: 0
      )
    }

    public var value: Int

    public init(value: Int) {
      self.value = value
    }
  }

  internal var overrideState: (State) throws -> Void
  public var doStuff: () -> Void

  public init(
    overrideState: @escaping (State) throws -> Void,
    doStuff: @escaping () -> Void
  ) {
    self.overrideState = overrideState
    self.doStuff = doStuff
  }

  public func override(state: State) throws {
    try self.overrideState(state)
  }
}
