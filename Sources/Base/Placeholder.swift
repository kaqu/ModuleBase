public struct Placeholder: TheError, Equatable {

  public static func error(
    message: String,
    file: StaticString,
    line: UInt
  ) -> Self {
    Self(
      message: message,
      file: file,
      line: line
    )
  }

  public let message: String
  public let file: StaticString
  public let line: UInt

  public static func == (
    _ lhs: Placeholder,
    _ rhs: Placeholder
  ) -> Bool {
    lhs.file.description == rhs.file.description
    && lhs.line == rhs.line
  }
}

public func placeholder<R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> () throws -> R {
  {
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1) throws -> R {
  { _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2) throws -> R {
  { _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3) throws -> R {
  { _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4) throws -> R {
  { _, _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5) throws -> R {
  { _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6) throws -> R {
  { _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7) throws -> R {
  { _, _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, A8, R>(
  _ message: String? = .none,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R {
  { _, _, _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message ?? "Placeholder",
        file: file,
        line: line
      )
  }
}
