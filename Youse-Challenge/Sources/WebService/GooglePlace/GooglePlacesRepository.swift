import Moya
import CoreLocation

enum YCError: Error {
    case serializationError
    case requestError
}

protocol GooglePlacesRepositoryProtocol {
    func getCarRepairList(with parameters: CarRepairParameters,
                          completion: @escaping (_ resultList: Result<ResultList>) -> Void)
    func getCarRepairDetails(with parameters: PlaceDetailsParameters,
                             completion: @escaping (_ resultList: Result<PlaceDetails>) -> Void)
}

final class GooglePlacesRepository: GooglePlacesRepositoryProtocol {    
    private let requestProvider: RequestProviderType

    init(requestProvider: RequestProviderType) {
        self.requestProvider = requestProvider
    }
    
    func getCarRepairList(with parameters: CarRepairParameters,
                          completion: @escaping (_ resultList: Result<ResultList>) -> Void) {
        self.requestProvider.request(target: GooglePlacesTarget.places(parameters)) { (result) in
            completion(result)
        }
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters,
                             completion: @escaping (_ resultList: Result<PlaceDetails>) -> Void) {
        self.requestProvider.request(target: GooglePlacesTarget.placeDetails(parameters)) { (result) in
            completion(result)
        }
    }
}
