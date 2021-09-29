import ModuleBase
import TestModuleInterface
import CommonFeatures

extension FeatureLoader where Feature == TestFeatureInterface {

  public static var stuffy: Self {
    Self { features in
      let property: StoredProperty<String> = try features.storedProperty(for: "stuffy")
      let isFirstLaunch: StoredProperty<Bool> = try features.storedProperty(for: "firstLaunch")
      return .init(
        doStuff: { print("stuffy") },
        loadValue: {
          property.load()
        },
        saveValue: { value in
          property.save(value)
        }
      )
    }
  }
}

