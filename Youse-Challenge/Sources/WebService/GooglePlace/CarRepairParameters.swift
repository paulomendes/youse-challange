import Foundation
import CoreLocation

struct CarRepairParameters: Parameterizable {
    let location: CLLocationCoordinate2D
    let radius: Int = 1000
    let types: String = "car_repair"
    
    func buildParameters() -> [String: Any] {
        return ["location": self.location.commaNotation(),
                "radius": self.radius,
                "types": self.types]
    }
}
