public func maybe<A, B>(b: B, f: A -> B, a: A?) -> B {
  switch a {
  case let .Some(x): return f(x)
  case .None: return b
  }
}
