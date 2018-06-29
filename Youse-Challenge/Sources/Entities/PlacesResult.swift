import Foundation

struct PlacesResult: Model {
    let icon: URL
    let placeId: String
    let name: String
    let rating: Double
    let vicinity: String
}

struct ResultList: Model {
    let results: [PlacesResult]
}
