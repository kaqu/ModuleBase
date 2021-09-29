import XCTest
@testable import ModuleBase
@testable import TestModule
import Base
import TestDependantModule
import TestModuleInterface
import TestDependantModuleInterface
import CommonFeatures

final class Tests: XCTestCase {

  func test() {
    do {
      try FeaturesRegistry.useUserDefaultsForStoredProperties()
      try FeaturesRegistry.use(
        loader: .stuffy,
        unloader: .noop,
        for: TestFeatureInterface.self
      )
      try FeaturesRegistry.use(
        loader: .dependantStuffy,
        unloader: .noop,
        for: TestDependantFeatureInterface.self
      )
    }
    catch let theError as TheError {
      theError
        .appending(.context(message: "Test failed"))
        .asFatalError()
    }
    catch {
      print("TestFeatureInterface failed")
    }

    let features: DynamicFeatures = .dynamic()
    let forkedFeatures: Features<Tests> = features.fork()
    do {
      let testInterface: TestFeatureInterface = try features.instance()
      print(testInterface.loadValue() as Any)
      testInterface.saveValue("updated")
      print(testInterface.loadValue() as Any)
      let testDependantInterface: TestDependantFeatureInterface = try features.instance()
      testDependantInterface.doDependantStuff()
      testInterface.saveValue("changed")
      let forkedDependantInterface: TestDependantFeatureInterface = try forkedFeatures.instance()
      forkedDependantInterface.doDependantStuff()
    }
    catch let theError as TheError {
      theError
        .appending(.context(message: "Test failed"))
        .asFatalError()
    }
    catch {
      print("TestFeatureInterface failed")
    }
  }
}
