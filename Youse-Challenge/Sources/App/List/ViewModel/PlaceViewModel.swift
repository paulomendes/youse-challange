import Foundation

enum ViewModelType {
    case error
    case loading
    case contentReady
}

struct ListTableViewModel {
    let type: ViewModelType
    let places: [PlaceViewModel]
    
    static func error() -> ListTableViewModel {
        return ListTableViewModel(type: .error, places: [])
    }
    
    static func loading() -> ListTableViewModel {
        return ListTableViewModel(type: .loading, places: [])
    }
    
    static func contentReady(with places: [PlaceViewModel]) -> ListTableViewModel {
        return ListTableViewModel(type: .contentReady, places: places)
    }
}

struct PlaceViewModel {
    let name: String
    let address: String
    let rating: String
    let placeId: String
    
    init(placeResult: PlacesResult) {
        self.name = placeResult.name
        self.address = placeResult.vicinity
        self.placeId = placeResult.placeId
        if let rating = placeResult.rating {
            self.rating = "Avaliação: \(rating)"
        } else {
            self.rating = "Sem Avaliação Disponível"
        }
    }
}
