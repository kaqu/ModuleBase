// "One Error to rule them all, One Error to handle them, One Error to bring them all, and on the screen bind them"
public protocol TheError: Error, CustomDebugStringConvertible {}

extension TheError {

  public var debugDescription: String { "\(Self.self)" }
}

public protocol TheLocalizedError: TheError, CustomStringConvertible {

  var localizedMessage: LocalizedString { get }
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
