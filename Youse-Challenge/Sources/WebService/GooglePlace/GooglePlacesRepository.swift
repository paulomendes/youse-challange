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
        return self.requestProvider.request(target: GooglePlacesTarget.places(parameters))
    }

    func getCarRepairDetails(with parameters: PlaceDetailsParameters) -> Single<PlaceDetails> {
        return self.requestProvider.request(target: GooglePlacesTarget.placeDetails(parameters))
    }
}
