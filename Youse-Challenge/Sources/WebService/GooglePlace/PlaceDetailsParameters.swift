import Foundation

struct PlaceDetailsParameters: Parameterizable {
    let placeId: String
    
    func buildParameters() -> [AnyHashable: Any] {
        return ["place_id" : self.placeId]
    }
}
