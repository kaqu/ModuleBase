public struct FeatureInstanceIdentifier: Hashable {

  internal let typeIdentifier: FeatureTypeIdentifier
  private let context: AnyHashable?

  private init(
    typeIdentifier: FeatureTypeIdentifier,
    context: AnyHashable?
  ) {
    self.typeIdentifier = typeIdentifier
    self.context = context
  }

  public var featureType: AnyFeature.Type
  { self.typeIdentifier.featureType }
}

extension FeatureInstanceIdentifier {

  internal static func identifier(
    for featureTypeIdentifier: FeatureTypeIdentifier,
    context: AnyHashable?
  ) -> Self {
    Self(
      typeIdentifier: featureTypeIdentifier,
      context: context
    )
  }

  internal static func identifier(
    for feature: AnyFeature,
    context: AnyHashable?
  ) -> Self {
    Self(
      typeIdentifier: type(of: feature).typeIdentifier,
      context: context
    )
  }

  internal static func identifier(
    for featureType: AnyFeature.Type,
    context: AnyHashable?
  ) -> Self {
    Self(
      typeIdentifier: featureType.typeIdentifier,
      context: context
    )
  }
}
