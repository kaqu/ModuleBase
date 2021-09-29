import Base
import ModuleBase

import class Foundation.FileHandle

public struct Console {

  public var lineIn: () -> String?
  public var out: (String) -> Void
  public var err: (String) -> Void
}

extension Console: ContextlessFeature {}

extension AnyFeatures {

  public var console: Console {
    get throws { try self.instance() }
  }
}

extension FeatureLoader where Feature == Console {

  public static var standard: Self {
    var stdOut: FileHandle = .standardOutput
    var stdErr: FileHandle = .standardError

    return Self(
      load: { _ in
        Feature(
          lineIn: { readLine() },
          out: { print($0, to: &stdOut) },
          err: { print($0, to: &stdErr) }
        )
      }
    )
  }
}
