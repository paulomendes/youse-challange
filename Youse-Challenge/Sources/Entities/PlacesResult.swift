import Foundation

struct PlacesResult: Decodable {
    let placeId: String
    let icon: URL
    let name: String
    let vicinity: String
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case icon
        case name
        case vicinity
    }
}

struct ResultList: Decodable {
    let results: [PlacesResult]
}
