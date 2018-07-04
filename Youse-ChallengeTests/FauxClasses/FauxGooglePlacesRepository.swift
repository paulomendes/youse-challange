import Foundation
@testable import Youse_Challenge

final class FauxGooglePlacesRepository: GooglePlacesRepositoryProtocol {
    private var resultList: Bool
    private var placeDetails: Bool
    private var error: Bool
    
    init(resultList: Bool = false, placeDetails: Bool = false, error: Bool = false) {
        self.resultList = resultList
        self.placeDetails = placeDetails
        self.error = error
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
        
        if self.error {
            completion(.failure(YCError.requestError))
        }
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters,
                             completion: @escaping (_ resultList: Result<PlaceDetails>) -> Void) {
        self.calledCarRepairDetails?()
        if self.placeDetails {
            let result = PlaceDetails.stubbed(from: "place-details")
            completion(.success(result))
        }
        
        if self.error {
            completion(.failure(YCError.requestError))
        }
    }
}

