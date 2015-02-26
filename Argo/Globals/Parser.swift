public enum Parser<T> {
  case Failure(String)
  case Success(Box<T>)

  public var value: T? {
    switch self {
    case let .Success(box): return box.value
    case .Failure(_): return .None
    }
  }
}

public final class Box<T> {
  let value: T
  public init(_ value: T) { self.value = value }
}
