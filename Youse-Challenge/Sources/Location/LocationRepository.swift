import INTULocationManager

protocol LocationRepositoryProtocol {
    func requestLocation(completion: @escaping (_ location: Result<CLLocation>) -> Void)
}

final class LocationRepository: LocationRepositoryProtocol {
    private let locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    func requestLocation(completion: @escaping (_ location: Result<CLLocation>) -> Void) {        
        self.locationManager.requestLocation { (location, intuAccuracy, intuStatus) in
            if let error = LocationError(intuStatus: intuStatus) {
                completion(Result.failure(error))
                return
            }
            guard let location = location else {
                completion(Result.failure(LocationError.unknown))
                return
            }
            completion(Result.success(location))
        }
    }
}
