import ModuleBase

public struct TestDependantFeatureInterface: StatelessFeature {

  public var doDependantStuff: () -> Void

  public init(
    doDependantStuff: @escaping () -> Void
  ) {
    self.doDependantStuff = doDependantStuff
  }
}
