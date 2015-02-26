public enum Parser<T> {
  case Success(Box<T>)
  case TypeMismatch(String)
  case MissingKey(String)

  public var value: T? {
    switch self {
    case let .Success(box): return box.value
    default: return .None
    }
  }
}

func parseOptional<A>(p: Parser<A>) -> Parser<A?> {
  switch p {
  case let .Success(box): return .Success(Box(.Some(box.value)))
  case let .MissingKey(string): return .Success(Box(.None))
  case let .TypeMismatch(string): return .TypeMismatch(string)
  }
}

public final class Box<T> {
  let value: T
  public init(_ value: T) { self.value = value }
}
