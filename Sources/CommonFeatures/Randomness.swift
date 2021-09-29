import Base
import ModuleBase

public struct Randomness {

  public typealias Unit = UInt64

  internal var randomNext: () -> Unit
}

extension Randomness: ContextlessFeature {}

extension AnyFeatures {

  public var randomness: Randomness {
    get throws { try self.instance() }
  }
}

extension Randomness: RandomNumberGenerator {

  public func next() -> Unit { randomNext() }

  public var rng: RandomNumberGenerator { self }
}

extension FeatureLoader where Feature == Randomness {

  public static var system: Self {
    var systemRandomNumberGenerator: SystemRandomNumberGenerator = .init()

    return Self(
      load: { _ in
        Feature(
          randomNext: { systemRandomNumberGenerator.next() }
        )
      }
    )
  }

  public static func linearCongruential(
    seed: Randomness.Unit = 0
  ) -> Self {
    let lock: SpinLock = .init()
    var seed = seed

    return Self(
      load: { _ in
        Feature(
          randomNext: {
            lock.withLock {
              seed = 2_862_933_555_777_941_757 &* seed &+ 3_037_000_493
              return seed
            }
          }
        )
      }
    )
  }

  public static func constant(
    _ value: Randomness.Unit
  ) -> Self {
    Self(
      load: { _ in
        Feature(
          randomNext: { value }
        )
      }
    )
  }
}
