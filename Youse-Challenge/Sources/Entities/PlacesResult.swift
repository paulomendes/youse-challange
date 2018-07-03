import Foundation

struct PlacesResult: Entity {
    let placeId: String
    let icon: URL
    let name: String
    let vicinity: String
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case icon
        case name
        case vicinity
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.placeId = try values.decode(String.self, forKey: .placeId)
        self.icon = try values.decode(URL.self, forKey: .icon)
        self.name = try values.decode(String.self, forKey: .name)
        self.vicinity = try values.decode(String.self, forKey: .vicinity)
        self.rating = try values.decodeIfPresent(Double.self, forKey: .rating)
    }
}

struct ResultList: Entity {
    let results: [PlacesResult]
}
