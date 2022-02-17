import Foundation

typealias IpAdress = String

extension IpAdress {
    var urlForGeoInfo: URL {
        return URL(string: "https://ipinfo.io/\(self)/geo")!
    }
}

struct IpData: Codable {
    let ip: IpAdress
}
