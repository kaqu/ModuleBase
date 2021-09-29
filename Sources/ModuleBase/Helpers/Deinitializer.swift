internal final class Deinitializer {

  private let action: () -> Void

  internal init(
    _ action: @escaping () -> Void
  ) {
    self.action = action
  }

  deinit { action() }
}
