import Argo
import Foundation

extension NSURL: JSONDecodable {
  public typealias DecodedType = NSURL

  public class func fromJSON(j: JSON) -> Parser<DecodedType> {
        switch j {
        case .String(let urlString):
          if let url = NSURL(string: urlString) {
            return .Success(Box(url))
          } else {
            return .Failure("\(urlString) is not a valid URL")
          }

        default: return typeMismatch("String", j)
        }
    }
}
