public struct StringEncodingFailure: TheError {

  public static func error(
    for string: String,
    encoding: String.Encoding,
    message: StaticString = "",
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      debugMeta: .info(
        message: message,
        file: file,
        line: line
      ),
      string: string,
      encoding: encoding
    )
  }

  public var debugMeta: DebugMeta
  public let string: String
  public let encoding: String.Encoding

  public var debugDescription: String {
    "\(Self.self) - encoding to \(self.encoding) failed for \"\(self.string) \(self.debugMeta.debugDescription)"
  }
}
