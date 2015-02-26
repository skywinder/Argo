import Runes

func flatReduce<S: SequenceType, U>(sequence: S, initial: U, combine: (U, S.Generator.Element) -> Parser<U>) -> Parser<U> {
  return reduce(sequence, pure(initial)) { accum, x in
    accum >>- { combine($0, x) }
  }
}
