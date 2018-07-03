import Moya

enum GooglePlacesTarget {
    case places(CarRepairParameters)
    case placeDetails(PlaceDetailsParameters)
}

extension GooglePlacesTarget: Target {
    var urlPath: String {
        switch self {
        case .places:
            return "place/nearbysearch/json"
        case .placeDetails:
            return "place/details/json"
        }
    }
    
    var parameters: Parameterizable {
        switch self {
        case .places(let parameters):
            return parameters
        case .placeDetails(let parameters):
            return parameters
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .placeDetails, .places:
            return .get
        }
    }
}
