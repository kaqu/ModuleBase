import Base
import ModuleBase

import class Foundation.UserDefaults

extension FeaturesRegistry {

  public static func useUserDefaultsForStoredProperties(
    suiteName: String? = .none
  ) throws {
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Bool>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Int>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Array<Int>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Dictionary<String, Int>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Double>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Array<Double>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Dictionary<String, Double>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<String>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Array<String>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Dictionary<String, String>>.self
    )
    try FeaturesRegistry.use(
      loader: .userDefaults(suiteName: suiteName),
      unloader: .noop,
      for: StoredProperty<Dictionary<String, Any>>.self
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<String> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
          ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .string(forKey: context.key.rawValue)
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Array<String>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .array(forKey: context.key.rawValue)
              as? Array<String>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Dictionary<String, String>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .dictionary(forKey: context.key.rawValue)
              as? Dictionary<String, String>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Int> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .integer(forKey: context.key.rawValue)
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Array<Int>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .array(forKey: context.key.rawValue)
              as? Array<Int>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Dictionary<String, Int>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .dictionary(forKey: context.key.rawValue)
              as? Dictionary<String, Int>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Double> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .double(forKey: context.key.rawValue)
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Array<Double>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .array(forKey: context.key.rawValue)
              as? Array<Double>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Dictionary<String, Double>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .dictionary(forKey: context.key.rawValue)
              as? Dictionary<String, Double>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Bool> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .bool(forKey: context.key.rawValue)
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Dictionary<String, Bool>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .dictionary(forKey: context.key.rawValue)
              as? Dictionary<String, Bool>
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}

extension FeatureLoader where Feature == StoredProperty<Dictionary<String, Any>> {

  public static func userDefaults(
    suiteName: String? = .none
  ) -> Self {
    let userDefaults: UserDefaults
    = suiteName.flatMap { .init(suiteName: $0) }
    ?? .standard

    return Self(
      load: { _, context in
        let resolvedUserDefaults: UserDefaults
        = context
          .storeIdentifier
          .flatMap { storeIdentifier in
            UserDefaults(suiteName: storeIdentifier.rawValue)
          }
        ?? userDefaults

        return Feature(
          context: context,
          load: {
            resolvedUserDefaults
              .dictionary(forKey: context.key.rawValue)
          },
          save: { value in
            resolvedUserDefaults
              .set(
                value,
                forKey: context.key.rawValue
              )
          }
        )
      }
    )
  }
}
