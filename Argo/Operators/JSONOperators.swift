import Runes

// MARK: Values

// Pull value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> Parser<A> {
  switch json {
  case let .Object(o):
    if let j = o[key] {
      return A.fromJSON(j)
    } else {
      return .Failure("\(key) not found")
    }
  default: return .Failure("\(json) is not an Object")
  }
}

// Pull optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> Parser<A?> {
  switch (json <| key) as Parser<A> {
  case let .Success(box): return pure(pure(box.value))
  case let .Failure(string): return pure(.None)
  }
}

// Pull embedded value from JSON
public func <|<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> Parser<A> {
  return flatReduce(keys, json, <|) >>- { A.fromJSON($0) }
}

// Pull embedded optional value from JSON
public func <|?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> Parser<A?> {
  switch (json <| keys) as Parser<A> {
  case let .Success(box): return pure(pure(box.value))
  case let .Failure(string): return pure(.None)
  }
}

// MARK: Arrays

// Pull array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> Parser<[A]> {
  return json <| key >>- decodeArray
}

// Pull optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, key: String) -> Parser<[A]?> {
  switch (json <|| key) as Parser<[A]> {
  case let .Success(box): return pure(pure(box.value))
  case let .Failure(string): return pure(.None)
  }
}

// Pull embedded array from JSON
public func <||<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> Parser<[A]> {
  return json <| keys >>- decodeArray
}

// Pull embedded optional array from JSON
public func <||?<A where A: JSONDecodable, A == A.DecodedType>(json: JSON, keys: [String]) -> Parser<[A]?> {
  switch (json <|| keys) as Parser<[A]> {
  case let .Success(box): return pure(pure(box.value))
  case let .Failure(string): return pure(.None)
  }
}

