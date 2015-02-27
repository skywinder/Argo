import Foundation
import Runes

extension String: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<String> {
    switch j {
    case let .String(s): return pure(s)
    default: return .typeMismatch("String", object: j)
    }
  }
}

extension Int: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Int> {
    switch j {
    case let .Number(n): return pure(n as Int)
    default: return .typeMismatch("Int", object: j)
    }
  }
}

extension Double: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Double> {
    switch j {
    case let .Number(n): return pure(n as Double)
    default: return .typeMismatch("Double", object: j)
    }
  }
}

extension Bool: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Bool> {
    switch j {
    case let .Number(n): return pure(n as Bool)
    default: return .typeMismatch("Bool", object: j)
    }
  }
}

extension Float: JSONDecodable {
  public static func fromJSON(j: JSON) -> Parser<Float> {
    switch j {
    case let .Number(n): return pure(n as Float)
    default: return .typeMismatch("Float", object: j)
    }
  }
}

public func decodeArray<A where A: JSONDecodable, A == A.DecodedType>(value: JSON) -> Parser<[A]> {
  switch value {
  case let .Array(a): return sequence({ A.fromJSON($0) } <^> a)
  default: return .typeMismatch("Array", object: value)
  }
}

public func decodeObject(value: JSON) -> Parser<[String:JSON]> {
  switch value {
  case let .Object(o): return pure(o)
  default: return .typeMismatch("Object", object: value)
  }
}
