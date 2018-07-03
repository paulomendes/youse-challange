import Foundation

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
