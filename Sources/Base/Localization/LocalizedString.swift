import class Foundation.Bundle
import func Foundation.NSLocalizedString

public struct LocalizedString {

  public static func localized(
    key: Key,
    tableName: String? = .none,
    bundle: Bundle = .main,
    arguments: Array<CVarArg> = .init()
  ) -> Self {
    Self(
      key: key,
      tableName: tableName,
      bundle: bundle,
      arguments: arguments
    )
  }

  public let key: Key
  public let tableName: String?
  public let bundle: Bundle
  public var arguments: Array<CVarArg>

  private init(
    key: Key,
    tableName: String?,
    bundle: Bundle,
    arguments: Array<CVarArg>
  ) {
    self.key = key
    self.tableName = tableName
    self.bundle = bundle
    self.arguments = arguments
  }

  public func string(
    with aruments: Array<CVarArg> = .init(),
    localizaton: (_ key: Key, _ tableName: String?, _ bundle: Bundle) -> String
    = { (key: Key, tableName: String?, bundle: Bundle) -> String in
      #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
      NSLocalizedString(
        key.rawValue,
        tableName: tableName,
        bundle: bundle,
        comment: ""
      )
      #else
      #error("Unsupported platform")
      #endif
    }
  ) -> String {
    let string: String = localizaton(self.key, self.tableName, self.bundle)

    var joinedArguments: Array<CVarArg> = self.arguments
    joinedArguments.append(contentsOf: arguments)

    if joinedArguments.isEmpty {
      return string
    }
    else {
      return String(
        format: string,
        arguments: joinedArguments
      )
    }
  }
}

extension LocalizedString: ExpressibleByStringLiteral {

  public init(
    stringLiteral: StaticString
  ) {
    self.init(
      key: .init(
        stringLiteral: stringLiteral
      ),
      tableName: .none,
      bundle: .main,
      arguments: .init()
    )
  }
}

extension LocalizedString {

  public struct Key: ExpressibleByStringLiteral {

    public var rawValue: String

    public init(
      stringLiteral: StaticString
    ) {
      self.rawValue = "\(stringLiteral)"
    }
  }
}
