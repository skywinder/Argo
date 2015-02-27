// pure merge for Dictionaries
func +<T, V>(var lhs: [T: V], rhs: [T: V]) -> [T: V] {
  var dict = lhs

  for (key, val) in rhs {
    dict[key] = val
  }

  return dict
}

// a better map for Dictionaries
func map<A, B, C>(dict: [A: B], f: B -> C) -> [A: C] {
  return map(dict) { [$0.0: f($0.1)] }.reduce([:], combine: (+))
}
