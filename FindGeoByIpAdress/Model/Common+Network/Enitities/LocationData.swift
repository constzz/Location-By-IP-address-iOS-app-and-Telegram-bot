import Foundation

typealias Location = String

struct LocationData: Codable {
    let city: String
    let region: String
    let country: String
    let loc: Location
}
