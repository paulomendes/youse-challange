import CoreLocation

extension CLLocationCoordinate2D {
    func commaNotation() -> String {
        return String(format: "%.7f,%.7f", self.latitude, self.longitude)
    }
}

