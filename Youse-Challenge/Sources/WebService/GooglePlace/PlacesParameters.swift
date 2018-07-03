import Foundation
import CoreLocation

struct PlacesParameters: Parameterizable {
    let location: CLLocationCoordinate2D
    let radius: Int
    let types: String
    
    func buildParameters() -> [String: Any] {
        return ["location": self.location.commaNotation(),
                "radius": self.radius,
                "types": self.types]
    }
}
