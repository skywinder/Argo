import Foundation
import Runes

public enum JSON {
  case Object([Swift.String: JSON])
  case Array([JSON])
  case String(Swift.String)
  case Number(NSNumber)
  case Null
}

public extension JSON {
  static func parse(json: AnyObject) -> JSON {
    switch json {
    case let v as [AnyObject]: return .Array(v.map(parse))

    case let v as [Swift.String: AnyObject]:
      return .Object(reduce(v.keys, [:]) { accum, key in
        let parsedValue = (self.parse <^> v[key]) ?? .Null
        return accum + [key: parsedValue]
      })

    case let v as Swift.String: return .String(v)
    case let v as NSNumber: return .Number(v)
    default: return .Null
    }
  }
}

extension JSON: JSONDecodable {
  public static func decode(j: JSON) -> JSON? {
    return j
  }
}

extension JSON: Printable {
  public var description: Swift.String {
    switch self {
    case let .String(v): return "String(\(v))"
    case let .Number(v): return "Number(\(v))"
    case let .Null: return "Null"
    case let .Array(a): return "Array(\(a.description))"
    case let .Object(o): return "Object(\(o.description))"
    }
  }
}

extension JSON: Equatable { }

public func ==(lhs: JSON, rhs: JSON) -> Bool {
  switch (lhs, rhs) {
  case let (.String(l), .String(r)): return l == r
  case let (.Number(l), .Number(r)): return l == r
  case let (.Null, .Null): return true
  case let (.Array(l), .Array(r)): return l == r
  case let (.Object(l), .Object(r)): return l == r
  default: return false
  }
}
