import Argo
import Foundation

extension NSURL: JSONDecodable {
  public typealias DecodedType = NSURL

  public class func fromJSON(j: JSON) -> Parser<NSURL> {
    switch j {
    case .String(let urlString): return maybe(typeMismatch("URL", j), pure, NSURL(string: urlString))
    default: return typeMismatch("URL", j)
    }
  }
}
