import Base
import ModuleBase

import class Foundation.ProcessInfo

public struct ProcessInfo {

  public var launchArgs: () -> Array<String>
}

extension ProcessInfo: ContextlessFeature {}

extension AnyFeatures {

  public var processInfo: ProcessInfo {
    get throws { try self.instance() }
  }
}

extension FeatureLoader where Feature == ProcessInfo {

  public static var live: Self {
    let processInfo: Foundation.ProcessInfo = .processInfo

    return Self(
      load: { _ in
        Feature(
          launchArgs: { processInfo.arguments }
        )
      }
    )
  }
}
