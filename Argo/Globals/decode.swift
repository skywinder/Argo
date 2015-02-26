public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> T? {
  return decode(object).value
}

public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> [T]? {
  return decode(object).value
}

public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<T> {
  return T.fromJSON(JSON.parse(object))
}

public func decode<T: JSONDecodable where T == T.DecodedType>(object: AnyObject) -> Parser<[T]> {
  return decodeArray(JSON.parse(object))
}
