import Foundation

struct PlaceDetailsParameters: Parameterizable {
    let placeId: String
    
    func buildParameters() -> [String: Any] {
        return ["place_id" : self.placeId]
    }
}
