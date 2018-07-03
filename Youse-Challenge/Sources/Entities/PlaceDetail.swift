import Foundation
import CoreLocation

struct Review: Model {
    let authorName: String
    let rating: Double
    let relativeTimeDescription: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case rating
        case relativeTimeDescription = "relative_time_description"
        case text
    }
}

struct PlaceDetails: Model {
    let formattedAddress: String
    let formattedPhoneNumber: String?
    let name: String
    let placeId: String
    let reviews: [Review]?
    let location: CLLocationCoordinate2D
    
    private enum RootKeys: String, CodingKey {
        case result
    }
    
    private enum GemoetryKeys: String, CodingKey {
        case location
    }
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case name
        case placeId = "place_id"
        case reviews
        case geometry
    }
    
    public init(from decoder: Decoder) throws {
        let rawValues = try decoder.container(keyedBy: RootKeys.self)
        let values = try rawValues.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
        self.formattedAddress = try values.decode(String.self, forKey: .formattedAddress)
        self.formattedPhoneNumber = try values.decodeIfPresent(String.self, forKey: .formattedPhoneNumber)
        self.name = try values.decode(String.self, forKey: .name)
        self.placeId = try values.decode(String.self, forKey: .placeId)
        self.reviews = try values.decodeIfPresent([Review].self, forKey: .reviews)
        
        let gemoetryValues = try values.nestedContainer(keyedBy: GemoetryKeys.self, forKey: .geometry)
        let location: [String: Double] = try gemoetryValues.decode([String: Double].self, forKey: .location)
        self.location = try CLLocationCoordinate2D(with: location)
    }
}
