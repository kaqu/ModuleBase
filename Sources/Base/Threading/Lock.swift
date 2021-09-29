import class Foundation.NSRecursiveLock
import class Foundation.NSLock

public protocol Lock {

  func lock()
  func unlock()
}

extension Lock {

  public func withLock<Result>(
    _ execute: () throws -> Result
  ) rethrows -> Result {
    self.lock()
    defer { self.unlock() }
    return try execute()
  }
}


extension NSLock: Lock {}
extension NSRecursiveLock: Lock {}
