import Base

public protocol AnyFeature {

  static var typeIdentifier: FeatureTypeIdentifier
  { get }
  var instanceIdentifier: FeatureInstanceIdentifier
  { get }
}

public protocol ContextlessFeature: AnyFeature {}

extension ContextlessFeature {

  public static var typeIdentifier: FeatureTypeIdentifier
  { .identifier(for: Self.self) }
  public var instanceIdentifier: FeatureInstanceIdentifier
  { .identifier(for: self, context: .none) }
}

public protocol ContextualFeature: AnyFeature {

  associatedtype Context: Hashable

  var context: Context { get }
}

extension ContextualFeature {

  public static var typeIdentifier: FeatureTypeIdentifier
  { .identifier(for: Self.self) }
  public var instanceIdentifier: FeatureInstanceIdentifier
  { .identifier(for: self, context: self.context) }
}
