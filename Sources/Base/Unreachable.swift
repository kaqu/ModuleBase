public func unreachable(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> Never {
  fatalError(
    "Unexpected behaviour: " + message,
    file: (file),
    line: line
  )
}

public func unreachable<R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> () throws -> R {
  {
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1) throws -> R {
  { _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2) throws -> R {
  { _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3) throws -> R {
  { _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, A4, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4) throws -> R {
  { _, _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, A4, A5, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5) throws -> R {
  { _, _, _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, A4, A5, A6, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6) throws -> R {
  { _, _, _, _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, A4, A5, A6, A7, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7) throws -> R {
  { _, _, _, _, _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}

public func unreachable<A1, A2, A3, A4, A5, A6, A7, A8, R>(
  _ message: String,
  file: StaticString = #filePath,
  line: UInt = #line
) -> (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R {
  { _, _, _, _, _, _, _, _ in
    fatalError(
      "Unexpected behaviour: " + message,
      file: (file),
      line: line
    )
  }
}
