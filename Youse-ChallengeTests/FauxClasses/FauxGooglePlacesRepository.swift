import RxSwift
import CoreLocation
@testable import Youse_Challenge

final class FauxGooglePlacesRepository: GooglePlacesRepositoryProtocol {
    private var resultList: Bool
    private var placeDetails: Bool
    
    init(resultList: Bool = false, placeDetails: Bool = false) {
        self.resultList = resultList
        self.placeDetails = placeDetails
    }
    
    var calledRepairList: (() -> Void)?
    var calledCarRepairDetails: (() -> Void)?
    
    func getCarRepairList(with parameters: CarRepairParameters) -> Single<ResultList> {
        self.calledRepairList?()
        
        if self.resultList {
            let result = ResultList.stubbed(from: "nearby")
            return Single.just(result)
        }
        return Single.never()
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters) -> Single<PlaceDetails> {
        self.calledCarRepairDetails?()
        if self.placeDetails {
            let result = PlaceDetails.stubbed(from: "place-details")
            return Single.just(result)
        }
        return Single.never()
    }
}

