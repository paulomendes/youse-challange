import CoreLocation

extension CLLocation {
    static var anyLocation: CLLocation {
        return CLLocation(latitude: CLLocationCoordinate2D.anyLocation.latitude,
                          longitude: CLLocationCoordinate2D.anyLocation.longitude)
    }
}
