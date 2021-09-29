public struct Undefined: TheError {

  public static func error(
    message: StaticString,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      debugMeta: .info(
        message: message,
        file: file,
        line: line
      )
    )
  }

  public var debugMeta: DebugMeta
}
