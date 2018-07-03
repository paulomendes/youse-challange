import Foundation
import RxSwift
import CoreLocation

protocol ListPresenterProtocol: Presenter {}

final class ListPresenter: ListPresenterProtocol {
    weak var viewController: ListTableViewControllerProtocol?
    weak var router: ListRouterProtocol?
   
    private let locationRepository: LocationRepositoryProtocol
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol

    private let disposeBag = DisposeBag()
    
    init(locationRepository: LocationRepositoryProtocol,
         googlePlacesRepository: GooglePlacesRepositoryProtocol) {
        self.locationRepository = locationRepository
        self.googlePlacesRepository = googlePlacesRepository
    }
    
    func start() {
        self.requestList()
    }
    
    private func requestList() {
        self.locationRepository
            .requestLocation()
            .asObservable()
            .flatMap(self.listPlaces)
            .asSingle()
            .subscribe { event in
                switch event {
                case .success(let places):
                    let viewModels = places.results.map(PlaceViewModel.init)
                    self.viewController?.show(viewModels: viewModels)
                case .error(let error):
                    print("Some error:\(error.localizedDescription)")
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func listPlaces(location: CLLocation) -> Observable<ResultList> {
        let parameters = PlacesParameters(location: location.coordinate,
                                          radius: 1000,
                                          types: "car_repair")
        
        return self.googlePlacesRepository
            .getCarRepairList(with: parameters)
            .asObservable()
    }
}

extension ListPresenter: ListTableViewControllerDelegate {
    func didSelectPlace(placeId: String) {
        self.router?.routeToDetails(with: placeId)
    }
}
