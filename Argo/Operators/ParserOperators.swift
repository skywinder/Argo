import Runes

public func >>-<A, B>(a: Parser<A>, f: A -> Parser<B>) -> Parser<B> {
  switch a {
  case let .Success(box): return f(box.value)
  case let .Failure(string): return .Failure(string)
  }
}

public func <^><A, B>(f: A -> B, a: Parser<A>) -> Parser<B> {
  switch a {
  case let .Success(box): return .Success(Box(f(box.value)))
  case let .Failure(string): return .Failure(string)
  }
}

public func <*><A, B>(f: Parser<A -> B>, a: Parser<A>) -> Parser<B> {
  switch f {
  case let .Success(box): return box.value <^> a
  case let .Failure(string): return .Failure(string)
  }
}

public func pure<A>(a: A) -> Parser<A> {
  return .Success(Box(a))
}
