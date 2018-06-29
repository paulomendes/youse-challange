import Moya
import CoreLocation
import RxSwift

enum YCError: Error {
    case serializationError
}

protocol GooglePlacesRepositoryProtocol {
    func getCarRepairList(with parameters: PlacesParameters) -> Maybe<ResultList>
    func getCarRepairDetail(with parameters: PlaceDetailsParameters) -> Single<PlaceDetail>
}

final class GooglePlacesRepository: GooglePlacesRepositoryProtocol {
    
    private let requestProvider: RequestProviderType
    
    init(requestProvider: RequestProviderType) {
        self.requestProvider = requestProvider
    }
    
    func getCarRepairList(with parameters: PlacesParameters) -> Maybe<ResultList> {
        return self.requestProvider
            .request(target: GooglePlacesTarget.places(parameters))
            .asObservable()
            .map {
                let data = try JSONDecoder().decode(ResultList.self, from: $0.data)
                return data
            }
            .asMaybe()
    }
    
    func getCarRepairDetail(with parameters: PlaceDetailsParameters) -> Single<PlaceDetail> {
        return self.requestProvider.request(target: GooglePlacesTarget.placeDetails(parameters))
    }
}
