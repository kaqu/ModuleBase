import Base

public struct FeatureUnimplemented: TheError, Equatable {

  public static let error: Self = .init()
}

public struct FeatureUnavailable: TheError, Equatable {

  public static let error: Self = .init()
}

public struct FeatureUnloadUnavailable: TheError, Equatable {

  public static let error: Self = .init()
}

public struct FeatureStateConflict: TheError, Equatable {

  public static let error: Self = .init()
}

public struct FeatureStateOverrideUnavailable: TheError, Equatable {

  public static let error: Self = .init()
}

public struct FeatureStateInvalid: TheError {

  public var underlyingError: TheError

  public static func error(
    with underlyingError: TheError
  ) -> Self {
    .init(underlyingError: underlyingError)
  }
}
