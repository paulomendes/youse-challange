import RxSwift
import CoreLocation
@testable import Youse_Challenge


final class FauxLocationRepository: LocationRepositoryProtocol {
    private var location: CLLocation?
    var calledRequestLocation: (() -> Void)?
    
    init(location: CLLocation? = nil) {
        self.location = location
    }
    
    func requestLocation() -> Single<CLLocation> {
        self.calledRequestLocation?()
        
        if let location = self.location {
            return Single.just(location)
        }
        
        return Single.never()
    }
}

