extension StaticString: Hashable {

  public static func == (
    _ lhs: StaticString,
    _ rhs: StaticString
  ) -> Bool {
    lhs.string == rhs.string
  }

  public func hash(
    into hasher: inout Hasher
  ) {
    hasher.combine(self.string)
  }
}
