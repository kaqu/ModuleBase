import struct Foundation.Data
import class Foundation.FileHandle

extension FileHandle: TextOutputStream {

  public func write(
    _ string: String
  ) {
    if let data: Data = string.data(using: .utf8) {
      self.write(data)
    }
    else {
      StringEncodingFailure
        .error(
          for: string,
          encoding: .utf8
        )
        .asFatalError()
    }
  }
}
