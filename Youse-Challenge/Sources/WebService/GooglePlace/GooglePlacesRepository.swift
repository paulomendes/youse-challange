import Moya
import CoreLocation
import RxSwift

enum YCError: Error {
    case serializationError
}

protocol GooglePlacesRepositoryProtocol {
    func getCarRepairList(with parameters: CarRepairParameters) -> Single<ResultList>
    func getCarRepairDetails(with parameters: PlaceDetailsParameters) -> Single<PlaceDetails>
}

final class GooglePlacesRepository: GooglePlacesRepositoryProtocol {
    
    private let requestProvider: RequestProviderType
    
    init(requestProvider: RequestProviderType) {
        self.requestProvider = requestProvider
    }
    
    func getCarRepairList(with parameters: CarRepairParameters) -> Single<ResultList> {
        return self.requestProvider
            .request(target: GooglePlacesTarget.places(parameters))
            .asObservable()
            .map {
                let data = try JSONDecoder().decode(ResultList.self, from: $0.data)
                return data
            }
            .asSingle()
    }
    
    func getCarRepairDetails(with parameters: PlaceDetailsParameters) -> Single<PlaceDetails> {
        return self.requestProvider
            .request(target: GooglePlacesTarget.placeDetails(parameters))
            .asObservable()
            .map {
                let data = try JSONDecoder().decode(PlaceDetails.self, from: $0.data)
                return data
            }
            .asSingle()
    }
}
