public struct Placeholder: TheError {

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

public func placeholder<R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> () -> R {
  {
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> () throws -> R {
  {
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1) -> R {
  { _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1) throws -> R {
  { _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2) -> R {
  { _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2) throws -> R {
  { _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3) -> R {
  { _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3) throws -> R {
  { _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4) -> R {
  { _, _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, A4, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4) throws -> R {
  { _, _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5) -> R {
  { _, _, _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, A4, A5, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5) throws -> R {
  { _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6) -> R {
  { _, _, _, _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6) throws -> R {
  { _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7) -> R {
  { _, _, _, _, _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7) throws -> R {
  { _, _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, A8, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7, A8) -> R {
  { _, _, _, _, _, _, _, _ in
    Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
      .asFatalError()
  }
}

public func placeholder<A1, A2, A3, A4, A5, A6, A7, A8, R>(
  _ message: StaticString = "Placeholder",
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R {
  { _, _, _, _, _, _, _, _ in
    throw Placeholder
      .error(
        message: message,
        file: file,
        line: line
      )
  }
}
