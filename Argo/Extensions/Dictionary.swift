// pure merge for Dictionaries
func +<T, V>(var lhs: [T: V], rhs: [T: V]) -> [T: V] {
  var dict = lhs

  for (key, val) in rhs {
    dict[key] = val
  }

  return dict
}

extension Dictionary {
  func map<A>(f: Value -> A) -> [Key: A] {
    return reduce(self, [:]) { $0 + [$1.0: f($1.1)] }
  }
}
