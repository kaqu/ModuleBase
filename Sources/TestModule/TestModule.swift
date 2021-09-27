import ModuleBase
@_exported import TestModuleInterface

extension FeatureLoader where Feature == TestFeatureInterface {

  public static var stuffy: Self {
    Self { features in
      .init(doStuff: { print("stuffy") })
    }
  }
}

extension FeatureLoader where Feature == TestStatefulFeatureInterface {

  public static var stateful: Self {
    Self { features, state in
      var state = state
      return .init(
        overrideState: { newState in
          state = newState
        },
        doStuff: {
            state.value += 1
            print("stuff state: \(state)")
          }
        )
    }
  }
}
