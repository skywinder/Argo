public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> T? {
  switch decodeResult(object) as Parser<T> {
  case let .Success(box): return box.value
  case .Failure(_): return .None
  }
}

public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> [T]? {
  switch decodeResult(object) as Parser<[T]> {
  case let .Success(box): return box.value
  case .Failure(_): return .None
  }
}

public func decodeResult<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<T> {
  return T.fromJSON(JSON.parse(object))
}

public func decodeResult<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<[T]> {
  return decodeArray(JSON.parse(object))
}
