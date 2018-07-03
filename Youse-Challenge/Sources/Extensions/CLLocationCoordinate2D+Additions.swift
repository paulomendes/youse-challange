import CoreLocation

extension CLLocationCoordinate2D {
    func commaNotation() -> String {
        return String(format: "%.7f,%.7f", self.latitude, self.longitude)
    }
}

extension CLLocationCoordinate2D {
    init(with googleLocationDictionary: [String: Double]) throws {
        guard let lat = googleLocationDictionary["lat"], let lng = googleLocationDictionary["lng"] else {
            throw YCError.serializationError
        }
        self.init(latitude: lat, longitude: lng)
    }
}
