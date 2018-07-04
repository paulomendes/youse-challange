import Foundation
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
    
    func getCarRepairList(with parameters: CarRepairParameters,
                          completion: @escaping (_ resultList: Result<ResultList>) -> Void) {
        self.calledRepairList?()
        if self.resultList {
            let result = ResultList.stubbed(from: "nearby")
            completion(.success(result))
        }
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters,
                             completion: @escaping (_ resultList: Result<PlaceDetails>) -> Void) {
        self.calledCarRepairDetails?()
        if self.placeDetails {
            let result = PlaceDetails.stubbed(from: "place-details")
            completion(.success(result))
        }
    }
}

