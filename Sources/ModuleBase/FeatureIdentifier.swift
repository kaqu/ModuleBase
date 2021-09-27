internal struct FeatureTypeIdentifier: Hashable {

  private let identifier: ObjectIdentifier

  internal init(
    identifier: ObjectIdentifier
  ) {
    self.identifier = identifier
  }
}

extension FeatureTypeIdentifier {

  internal static func `for`<Feature>(
    _ feature: Feature
  ) -> Self
  where Feature: AnyFeature {
    Self(
      identifier: ObjectIdentifier(type(of: feature))
    )
  }

  internal static func `for`<Feature>(
    _ featureType: Feature.Type
  ) -> Self
  where Feature: AnyFeature {
    Self(
      identifier: ObjectIdentifier(featureType)
    )
  }
}

internal struct FeatureInstanceIdentifier: Hashable {

  private let typeIdentifier: FeatureTypeIdentifier
  private let context: AnyHashable?

  internal init(
    typeIdentifier: FeatureTypeIdentifier,
    context: AnyHashable? = nil
  ) {
    self.typeIdentifier = typeIdentifier
    self.context = context
  }
}

extension FeatureInstanceIdentifier {

  internal static func `for`<Feature>(
    contextless feature: Feature
  ) -> Self
  where Feature: AnyContextlessFeature {
    Self(
      typeIdentifier: .for(feature),
      context: nil
    )
  }

  internal static func `for`<Feature>(
    contextless featureType: Feature.Type
  ) -> Self
  where Feature: AnyContextlessFeature {
    Self(
      typeIdentifier: .for(featureType),
      context: nil
    )
  }

  internal static func `for`<Feature>(
    contextual feature: Feature
  ) -> Self
  where Feature: AnyContextualFeature {
    Self(
      typeIdentifier: .for(feature),
      context: feature.context
    )
  }

  internal static func `for`<Feature>(
    contextual featureType: Feature.Type,
    in context: Feature.Context
  ) -> Self
  where Feature: AnyContextualFeature {
    Self(
      typeIdentifier: .for(featureType),
      context: context
    )
  }
}
