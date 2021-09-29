import Base
import ModuleBase

import class Foundation.Bundle
import struct Foundation.URL
import func Foundation.uname
import struct Foundation.utsname

#if os(iOS)
import class UIKit.UIDevice
#endif

public struct SystemInfo {

  public var hardwareModel: () -> String
  public var osVersion: () -> String
  public var appVersion: () -> String
  public var diskSpace: () -> String
}

extension SystemInfo: ContextlessFeature {}

extension AnyFeatures {

  public var systemInfo: SystemInfo {
    get throws { try self.instance() }
  }
}

extension FeatureLoader where Feature == SystemInfo {

  public static var live: Self {

    func hardwareModel() -> String {
      var systemInfo = utsname()
      uname(&systemInfo)
      let machineMirror = Mirror(reflecting: systemInfo.machine)
      return machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
      }
    }

    func osVersion() -> String {
#if os(iOS)
      UIDevice.current.systemVersion
#else
      "N/A"
#endif
    }

    func appVersion() -> String {
      Bundle.main
        .infoDictionary?["CFBundleShortVersionString"]
      as? String
      ?? "?.?.?"
    }

    func diskSpace() -> String {
      (try? URL(
        fileURLWithPath: "/"
      )
        .resourceValues(
          forKeys: [.volumeAvailableCapacityForImportantUsageKey]
        ))?
        .volumeAvailableCapacityForImportantUsage
        .map { "\($0) bytes" }
      ?? "N/A"
    }

    return Self(
      load: { _ in
        Feature(
          hardwareModel: hardwareModel,
          osVersion: osVersion,
          appVersion: appVersion,
          diskSpace: diskSpace
        )
      }
    )
  }
}
