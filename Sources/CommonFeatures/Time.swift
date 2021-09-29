import Base
import ModuleBase

import func Foundation.time

public struct Time {

  /// Number of seconds from beginning of epoch (1/1/1970)
  public var posixTimeNow: () -> Int
}

extension Time: ContextlessFeature {}

extension AnyFeatures {

  public var time: Time {
    get throws { try self.instance() }
  }
}

extension FeatureLoader where Feature == Time {

  public static var live: Self {
    Self(
      load: { _ in
        Feature(
          posixTimeNow: { time(nil) }
        )
      }
    )
  }
}
