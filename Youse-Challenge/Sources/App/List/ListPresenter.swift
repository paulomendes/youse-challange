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
            .flatMap(self.carRepairList)
            .asSingle()
            .subscribe { [weak self] event in
                self?.handleCarRepairList(event)
            }.disposed(by: self.disposeBag)
    }
    
    private func carRepairList(location: CLLocation) -> Observable<ResultList> {
        return self.googlePlacesRepository
            .getCarRepairList(with: CarRepairParameters(location: location.coordinate))
            .asObservable()
    }
    
    private func handleCarRepairList(_ event: SingleEvent<ResultList>) {
        switch event {
        case .success(let places):
            let viewModels = places.results.map(PlaceViewModel.init)
            self.viewController?.show(viewModels: viewModels)
        case .error(let error):
            print("Some error:\(error.localizedDescription)")
        }
    }
}

extension ListPresenter: ListTableViewControllerDelegate {
    func didSelectPlace(placeId: String) {
        self.router?.routeToDetails(with: placeId)
    }
}
