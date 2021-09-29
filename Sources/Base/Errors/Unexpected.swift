public struct Unexpected: TheError {

  public static func error(
    message: StaticString,
    localizedMessage: LocalizedString? = nil,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      debugMeta: .info(
        message: message,
        file: file,
        line: line
      ),
      localizedMessage: localizedMessage
    )
  }

  public var debugMeta: DebugMeta
  public let localizedMessage: LocalizedString?
}
