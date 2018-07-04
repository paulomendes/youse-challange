import RxSwift
import CoreLocation
@testable import Youse_Challenge

final class FauxGooglePlacesRepository: GooglePlacesRepositoryProtocol {
    func getCarRepairList(with parameters: CarRepairParameters) -> Single<ResultList> {
        return Single.never()
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters) -> Single<PlaceDetails> {
        return Single.never()
    }
}

