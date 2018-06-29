import Foundation

struct Review: Model {
    let authorName: String
    let rating: Double
    let relativeTimeDescription: String
    let text: String
    let profilePhoto: URL
}

struct PlaceDetail: Model {
    let formattedAddress: String
    let formattedPhoneNumber: String
    let name: String
    let placeId: String
    let rating: Double
}
