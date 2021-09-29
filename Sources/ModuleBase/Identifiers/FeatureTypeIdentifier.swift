public struct FeatureTypeIdentifier: Hashable {

  public static func == (
    _ lhs: FeatureTypeIdentifier,
    _ rhs: FeatureTypeIdentifier
  ) -> Bool {
    lhs.identifier == rhs.identifier
  }

  public let featureType: AnyFeature.Type
  private let identifier: ObjectIdentifier


  private init(
    featureType: AnyFeature.Type
  ) {
    self.identifier = ObjectIdentifier(featureType)
    self.featureType = featureType
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.identifier)
  }
}

extension FeatureTypeIdentifier {

  internal static func identifier(
    for featureType: AnyFeature.Type
  ) -> Self {
    Self(
      featureType: featureType
    )
  }

  internal static func identifier(
    for feature: AnyFeature
  ) -> Self {
    Self(
      featureType: type(of: feature)
    )
  }
}
