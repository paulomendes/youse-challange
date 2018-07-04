import CoreLocation
@testable import Youse_Challenge

final class FauxLocationRepository: LocationRepositoryProtocol {
    private var location: CLLocation?
    var calledRequestLocation: (() -> Void)?
    
    init(location: CLLocation? = nil) {
        self.location = location
    }
    
    func requestLocation(completion: @escaping (_ location: Result<CLLocation>) -> Void) {
        self.calledRequestLocation?()
        if let location = self.location {
            completion(.success(location))
        }
    }
}

