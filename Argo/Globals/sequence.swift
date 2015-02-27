import Runes

func sequence<T>(xs: [Parser<T>]) -> Parser<[T]> {
  return reduce(xs, pure([])) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}

func sequence<T>(xs: [String: Parser<T>]) -> Parser<[String: T]> {
  return reduce(xs, pure([:])) { accum, elem in
    return curry(+) <^> accum <*> ({ [elem.0: $0] } <^> elem.1)
  }
}
