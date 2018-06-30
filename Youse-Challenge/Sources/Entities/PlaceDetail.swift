import Foundation

struct Review: Model {
    let authorName: String
    let rating: Double
    let relativeTimeDescription: String
    let text: String
    let profilePhoto: URL
    
    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case rating
        case relativeTimeDescription = "relative_time_description"
        case text
        case profilePhoto = "profile_photo_url"
    }
}

struct PlaceDetail: Model {
    let formattedAddress: String
    let formattedPhoneNumber: String
    let name: String
    let placeId: String
    let reviews: [Review]
    
    private enum RootKeys: String, CodingKey {
        case result
    }
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case name
        case placeId = "place_id"
        case reviews
    }
    
    public init(from decoder: Decoder) throws {
        let rawValues = try decoder.container(keyedBy: RootKeys.self)
        let values = try rawValues.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        self.formattedAddress = try values.decode(String.self, forKey: .formattedAddress)
        self.formattedPhoneNumber = try values.decode(String.self, forKey: .formattedPhoneNumber)
        self.name = try values.decode(String.self, forKey: .name)
        self.placeId = try values.decode(String.self, forKey: .placeId)
        self.reviews = try values.decode([Review].self, forKey: .reviews)
    }
}
