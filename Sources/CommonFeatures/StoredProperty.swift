import Base
import ModuleBase

public struct StoredProperty<Value> {

  public let context: Context
  public var load: () -> Value?
  public var save: (Value?) -> Void
}

extension StoredProperty: ContextualFeature {

  public typealias Context = Identifier<Value>
}

extension StoredProperty {

  public struct Identifier<Value>: Hashable {

    public typealias Key = Tagged<String, StoreIdentifier>
    public typealias StoreIdentifier = Tagged<String, Self>

    public var key: Key
    public var storeIdentifier: StoreIdentifier?
  }
}

extension StoredProperty.Identifier {

  public static func identifier(
    _ key: Key,
    storeIdentifier: StoreIdentifier? = .none
  ) -> Self {
    Self(
      key: key,
      storeIdentifier: storeIdentifier
    )
  }
}

extension StoredProperty.Identifier: ExpressibleByStringLiteral {

  public init(
    stringLiteral value: StaticString
  ) {
    self.key = .init(rawValue: value.string)
    self.storeIdentifier = .none
  }
}

extension AnyFeatures {

  public func storedProperty<Value>(
    for context: StoredProperty<Value>.Context
  ) throws -> StoredProperty<Value> {
    try self.instance(context: context)
  }
}

