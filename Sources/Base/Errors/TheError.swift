// "One Error to rule them all, One Error to handle them, One Error to bring them all, and on the screen bind them"
public protocol TheError: Error, CustomDebugStringConvertible {

  var debugMeta: DebugMeta { get set }

  func asFatalError(
    message: String?
  ) -> Never
}

extension TheError {

  public var debugDescription: String { "\(Self.self)\n \(self.debugMeta.debugDescription)" }

  public func asFatalError(
    message: String? = .none
  ) -> Never {
    fatalError("\(message.map { "\($0)\n" } ?? "")\(self.debugDescription)")
  }

  public mutating func append(
    _ context: DebugMeta.SourceCodeContext
  ) {
    self.debugMeta.append(context)
  }

  public func appending(
    _ context: DebugMeta.SourceCodeContext
  ) -> Self {
    var copy: Self = self
    copy.append(context)
    return copy
  }
}

public protocol TheLocalizedError: TheError, CustomStringConvertible {

  var localizedMessage: LocalizedString? { get }
}

extension TheLocalizedError {

  public var localizedMessage: LocalizedString
  { .localized(key: "%@", arguments: ["\(Self.self)"]) }
  public var description: String
  { self.localizedMessage.string() }
}

extension Error {

  public static func ~=<OtherError>(
    _ lhs: OtherError,
    _ rhs: Self
  ) -> Bool
  where OtherError: TheError & Equatable {
    (rhs as? OtherError) == lhs
  }
}
