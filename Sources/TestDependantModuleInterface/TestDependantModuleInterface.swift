import ModuleBase

public struct TestDependantFeatureInterface: ContextlessFeature {

  public var doDependantStuff: () -> Void

  public init(
    doDependantStuff: @escaping () -> Void
  ) {
    self.doDependantStuff = doDependantStuff
  }
}
