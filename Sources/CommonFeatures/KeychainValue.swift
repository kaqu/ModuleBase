import Base
import ModuleBase

public struct KeychainValue<Value> {

  public let context: Context
  public var load: () -> Value?
  public var save: (Value?) -> Void
}

extension KeychainValue: ContextualFeature {

  public typealias Context = Query
}

extension KeychainValue {
  
  public struct Query: Hashable {

    public typealias Key = Tagged<String, Value>
    public typealias Tag = Tagged<String, Key>

    public var key: Key
    public var tag: Tag?

    public init(
      key: Key,
      tag: Tag?
    ) {
      self.key = key
      self.tag = tag
    }
  }
}

extension AnyFeatures {

  public func keychainValue<Value>(
    for context: KeychainValue<Value>.Context
  ) throws -> KeychainValue<Value> {
    try self.instance(context: context)
  }
}

extension FeaturesRegistry {

  public static func useSystemKeychainForKeychainValues() throws {
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Bool>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Int>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Array<Int>>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Dictionary<String, Int>>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Double>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Array<Double>>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Dictionary<String, Double>>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<String>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Array<String>>.self
//    )
//    try FeaturesRegistry.use(
//      loader: .userDefaults(),
//      unloader: .noop,
//      for: Preferences<Dictionary<String, String>>.self
//    )
  }
}

//extension FeatureLoader where Feature == Keychain<String> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .string(forKey: context.rawValue)
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Array<String>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .array(forKey: context.rawValue)
//            as? Array<String>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Dictionary<String, String>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .dictionary(forKey: context.rawValue)
//            as? Dictionary<String, String>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Int> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .integer(forKey: context.rawValue)
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Array<Int>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .array(forKey: context.rawValue)
//            as? Array<Int>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Dictionary<String, Int>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .dictionary(forKey: context.rawValue)
//            as? Dictionary<String, Int>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Double> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .double(forKey: context.rawValue)
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Array<Double>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .array(forKey: context.rawValue)
//            as? Array<Double>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Dictionary<String, Double>> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .dictionary(forKey: context.rawValue)
//            as? Dictionary<String, Double>
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
//extension FeatureLoader where Feature == Preferences<Bool> {
//
//  public static func userDefaults(
//    suiteName: String? = .none
//  ) -> Self {
//    let userDefaults: UserDefaults
//    = suiteName.flatMap { .init(suiteName: $0) }
//    ?? .standard
//
//    return Self(
//      load: { _, context in
//        Feature(
//          context: context,
//          load: {
//            userDefaults
//              .bool(forKey: context.rawValue)
//          },
//          save: { value in
//            userDefaults
//              .set(
//                value,
//                forKey: context.rawValue
//              )
//          }
//        )
//      }
//    )
//  }
//}
//
