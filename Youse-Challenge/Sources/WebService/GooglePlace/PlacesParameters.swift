import Foundation
import CoreLocation

struct PlacesParameters: Parameterizable {
    let location: CLLocationCoordinate2D
    let radius: Int
    let types: String
    
    func buildParameters() -> [AnyHashable: Any] {
        return ["location": self.location.commaNotation(),
                "radius": self.radius,
                "types": self.types]
    }
}
