import ModuleBase

public struct TestFeatureInterface: ContextlessFeature {

  public var doStuff: () -> Void
  public var loadValue: () -> String?
  public var saveValue: (String?) -> Void

  public init(
    doStuff: @escaping () -> Void,
    loadValue: @escaping () -> String?,
    saveValue: @escaping (String?) -> Void
  ) {
    self.doStuff = doStuff
    self.loadValue = loadValue
    self.saveValue = saveValue
  }
}
