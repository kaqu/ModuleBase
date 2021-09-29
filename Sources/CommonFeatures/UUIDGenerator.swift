import Base
import ModuleBase

import struct Foundation.UUID

public struct UUIDGenerator {

  public var uuid: () -> UUID
}

extension UUIDGenerator: ContextlessFeature {}

extension AnyFeatures {

  public var uuidGenerator: UUIDGenerator {
    get throws { try self.instance() }
  }
}

extension FeatureLoader where Feature == UUIDGenerator {

  public static var live: Self {
    Self(
      load: { _ in
        Feature(
          uuid: UUID.init
        )
      }
    )
  }
}
