import Runes

func sequence<T>(xs: [Parser<T>]) -> Parser<[T]> {
  return reduce(xs, pure([])) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}
