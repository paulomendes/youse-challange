import INTULocationManager
import RxSwift

protocol LocationRepositoryProtocol {
    func requestLocation() -> Single<CLLocation>
}

final class LocationRepository: LocationRepositoryProtocol {
    private let locationManager: LocationManagerProtocol
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    func requestLocation() -> Single<CLLocation> {
        return Single.create { single in
            let locationRequestId =
                self.locationManager.requestLocation { (location, intuAccuracy, intuStatus) in
                    if let error = LocationError(intuStatus: intuStatus) {
                        single(.error(error))
                        return
                    }
                    guard let location = location else {
                        single(.error(LocationError.unknown))
                        return
                    }
                    single(.success(location))
            }
            return Disposables.create {
                self.locationManager.cancelLocationRequest(locationRequestId)
            }
            }.subscribeOn(MainScheduler.instance)
    }
}
