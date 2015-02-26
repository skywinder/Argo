public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> T? {
  return decodeResult(object).value
}

public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> [T]? {
  return decodeResult(object).value
}

public func decodeResult<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<T> {
  return T.fromJSON(JSON.parse(object))
}

public func decodeResult<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<[T]> {
  return decodeArray(JSON.parse(object))
}
