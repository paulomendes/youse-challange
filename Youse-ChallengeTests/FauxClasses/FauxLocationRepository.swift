import RxSwift
import CoreLocation
@testable import Youse_Challenge


final class FauxLocationRepository: LocationRepositoryProtocol {
    func requestLocation() -> Single<CLLocation> {
        return Single.never()
    }
}

