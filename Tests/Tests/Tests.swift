import XCTest
@testable import ModuleBase
@testable import TestModule
import TestDependantModule

final class Tests: XCTestCase {

  func test() {
    FeaturesRegistry.use(.stuffy, for: TestFeatureInterface.self)
    FeaturesRegistry.use(.stateful, for: TestStatefulFeatureInterface.self)
    FeaturesRegistry.use(.dependantStuffy, for: TestDependantFeatureInterface.self)

    let features: LazyFeatures = .init()
    do {
      let testInterface: TestDependantFeatureInterface = try features.instance()
      testInterface.doDependantStuff()
    }
    catch {
      print("TestFeatureInterface failed")
    }

    do {
      let testInterface: TestStatefulFeatureInterface = try features.instance(in: TestStatefulFeatureInterface.State.init(value: 0))
      testInterface.doStuff()
      testInterface.doStuff()
      let testInterfaceUpdated: TestStatefulFeatureInterface = try features.instance(in: TestStatefulFeatureInterface.State.init(value: 41))
      testInterface.doStuff()
      testInterfaceUpdated.doStuff()
    }
    catch {
      print("TestStatefulFeatureInterface failed")
    }
  }
}
