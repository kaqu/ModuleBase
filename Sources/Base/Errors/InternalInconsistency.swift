public struct InternalInconsistency: TheLocalizedError {

  public static func error(
    message: StaticString,
    localizedMessage: LocalizedString? = .none,
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
