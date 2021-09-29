import ModuleBase
@_exported import TestDependantModuleInterface
import TestModuleInterface

extension FeatureLoader where Feature == TestDependantFeatureInterface {

  public static var dependantStuffy: Self {
    Self { features in
      let dependence = try features.instance(of: TestFeatureInterface.self)
      return .init(doDependantStuff: { print("dependant: \(dependence.loadValue() ?? "")") })
    }
  }
}
