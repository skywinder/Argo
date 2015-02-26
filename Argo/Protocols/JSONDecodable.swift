public protocol JSONDecodable {
  typealias DecodedType = Self
  static func fromJSON(json: JSON) -> Parser<DecodedType>
}
