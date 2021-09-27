import libkern

internal final class SpinLock {

  private let ptr: AtomicFlag.Pointer

  internal init() {
    self.ptr = AtomicFlag.make()
    // ensure false initially
    AtomicFlag.clear(self.ptr)
  }

  deinit {
    AtomicFlag.destroy(self.ptr)
  }

  internal func lock() {
    while AtomicFlag.readAndSet(self.ptr) {}
  }

  internal func unlock() {
    AtomicFlag.clear(self.ptr)
  }

  internal func withLock<Result>(
    _ execute: () -> Result
  ) -> Result {
    self.lock()
    defer { self.unlock() }
    return execute()
  }
}

private enum AtomicFlag {

  /// atomic_flag pointer type
  fileprivate typealias Pointer = UnsafeMutablePointer<atomic_flag>

  /// Atomic flag is initialized not set (false)
  ///
  /// - Returns: Pointer to new ataomic flag instance
  fileprivate static func make() -> Pointer {
    let pointer = Pointer.allocate(capacity: 1)
    pointer.pointee = atomic_flag()
    return pointer
  }

  /// - Parameter pointer: Pointer to flag to be destroyed.
  fileprivate static func destroy(_ pointer: Pointer) {
    pointer.deinitialize(count: 1)
    pointer.deallocate()
  }

  /// Reads current value of flag and sets it to true
  ///
  /// - Parameter pointer: Pointer to flag to be read and set.
  fileprivate static func readAndSet(_ pointer: Pointer) -> Bool {
    return atomic_flag_test_and_set(pointer)
  }

  /// Clears flag (set to false)
  ///
  /// - Parameter pointer: Pointer to flag to be cleared.
  fileprivate static func clear(_ pointer: Pointer) {
    atomic_flag_clear(pointer)
  }
}
