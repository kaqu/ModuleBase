public struct Tagged<RawValue, Tag>: RawRepresentable {

  public var rawValue: RawValue

  public init(
    rawValue: RawValue
  ) {
    self.rawValue = rawValue
  }
}

extension Tagged: CustomStringConvertible
where RawValue: CustomStringConvertible {

  public var description: String {
    rawValue.description
  }
}

extension Tagged: LosslessStringConvertible
where RawValue: LosslessStringConvertible {

  public init?(
    _ description: String
  ) {
    guard let rawValue = RawValue(description)
    else { return nil }
    self.init(rawValue: rawValue)
  }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral
where RawValue: ExpressibleByUnicodeScalarLiteral {

  public init(
    unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType
  ) {
    self.init(
      rawValue: RawValue(
        unicodeScalarLiteral: value
      )
    )
  }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral
where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {

  public init(
    extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType
  ) {
    self.init(
      rawValue: RawValue(
        extendedGraphemeClusterLiteral: value
      )
    )
  }
}

extension Tagged: ExpressibleByStringLiteral
where RawValue: ExpressibleByStringLiteral {

  public init(
    stringLiteral value: RawValue.StringLiteralType
  ) {
    self.init(
      rawValue: RawValue(
        stringLiteral: value
      )
    )
  }
}

extension Tagged: ExpressibleByStringInterpolation
where RawValue: ExpressibleByStringInterpolation {

  public init(
    stringInterpolation value: RawValue.StringInterpolation
  ) {
    self.init(
      rawValue: RawValue(
        stringInterpolation: value
      )
    )
  }
}

extension Tagged: ExpressibleByIntegerLiteral
where RawValue: ExpressibleByIntegerLiteral {

  public init(
    integerLiteral value: RawValue.IntegerLiteralType
  ) {
    self.init(
      rawValue: RawValue(
        integerLiteral: value
      )
    )
  }
}

extension Tagged: ExpressibleByFloatLiteral
where RawValue: ExpressibleByFloatLiteral {

  public init(
    floatLiteral value: RawValue.FloatLiteralType
  ) {
    self.init(
      rawValue: RawValue(
        floatLiteral: value
      )
    )
  }
}

extension Tagged: ExpressibleByNilLiteral
where RawValue: ExpressibleByNilLiteral {

  public init(
    nilLiteral: Void
  ) {
    self.init(
      rawValue: RawValue(
        nilLiteral: Void()
      )
    )
  }
}

extension Tagged: Encodable
where RawValue: Encodable {

  public func encode(to encoder: Encoder) throws {
    try rawValue.encode(to: encoder)
  }
}

extension Tagged: Decodable
where RawValue: Decodable {

  public init(from decoder: Decoder) throws {
    self.rawValue = try RawValue(from: decoder)
  }
}

extension Tagged: Equatable
where RawValue: Equatable {

  public static func == (
    _ lhs: RawValue,
    _ rhs: Tagged
  ) -> Bool {
    lhs == rhs.rawValue
  }

  public static func == (
    _ lhs: Tagged,
    _ rhs: RawValue
  ) -> Bool {
    lhs.rawValue == rhs
  }
}

extension Tagged: Hashable
where RawValue: Hashable {}

extension Tagged
where RawValue: Equatable {

  public static func ~= (
    _ lhs: RawValue,
    _ rhs: Tagged
  ) -> Bool {
    lhs == rhs.rawValue
  }
}
