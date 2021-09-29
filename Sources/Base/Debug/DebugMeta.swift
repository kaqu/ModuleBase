public struct DebugMeta: CustomStringConvertible, CustomDebugStringConvertible {

  public static func info(
    message: StaticString,
    error: Error? = .none,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Self {
    Self(
      contextStack: [
        .context(
          message: message,
          error: error,
          file: file,
          line: line
        )
      ]
    )
  }

  public var contextStack: Array<SourceCodeContext>

  public mutating func append(
    _ context: SourceCodeContext
  ) {
    self.contextStack.append(context)
  }

  public func appending(
    _ context: SourceCodeContext
  ) -> Self {
    var copy: Self = self
    copy.append(context)
    return copy
  }

  public var description: String {
    self.contextStack
      .reduce(into: "") { result, context in
        result.append("\(context.description)\n")
      }
  }

  public var debugDescription: String {
    self.description
  }
}

extension DebugMeta {

  public struct SourceCodeContext: CustomStringConvertible, CustomDebugStringConvertible {

    public static func context(
      message: StaticString,
      error: Error? = .none,
      file: StaticString = #filePath,
      line: UInt = #line
    ) -> Self {
      Self(
        message: message,
        error: error,
        sourceCodeLocation: .here(
          file: file,
          line: line
        )
      )
    }

    public let message: StaticString
    public let error: Error?
    public let sourceCodeLocation: SourceCodeLocation

    public var description: String {
      var description: String = ""
      if self.message.isEmpty {
        description.append(self.message.string)
      }
      else {
        /* noop */
      }

      if let error: Error = self.error {
        if description.isEmpty {
          description.append("Error: \(error)")
        }
        else {
          description.append(", error: \(error)")
        }
      }
      else {
        /* noop */
      }

      if description.isEmpty {
        description.append("At: \(self.sourceCodeLocation.description)")
      }
      else {
        description.append("\n  at: \(self.sourceCodeLocation.description)")
      }
      
      return description
    }

    public var debugDescription: String {
      self.description
    }
  }

  public struct SourceCodeLocation: Hashable, CustomStringConvertible, CustomDebugStringConvertible {

    public static func here(
      file: StaticString = #filePath,
      line: UInt = #line
    ) -> Self {
      Self(
        file: file,
        line: line
      )
    }

    public let file: StaticString
    public let line: UInt

    public var description: String {
      "\(self.file):\(self.line)"
    }

    public var debugDescription: String {
      self.description
    }
  }
}
