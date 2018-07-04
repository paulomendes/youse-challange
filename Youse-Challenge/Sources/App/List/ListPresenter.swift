import Foundation
import CoreLocation

protocol ListPresenterProtocol: Presenter {}

final class ListPresenter: ListPresenterProtocol {
    weak var viewController: ListTableViewControllerProtocol?
    weak var router: ListRouterProtocol?
   
    private let locationRepository: LocationRepositoryProtocol
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol
    
    init(locationRepository: LocationRepositoryProtocol,
         googlePlacesRepository: GooglePlacesRepositoryProtocol) {
        self.locationRepository = locationRepository
        self.googlePlacesRepository = googlePlacesRepository
    }
    
    func start() {
        self.requestList()
    }
    
    private func handleUserLocation(_ location: CLLocation) {
        self.googlePlacesRepository
            .getCarRepairList(with: CarRepairParameters(location: location.coordinate)) { [weak self] (resullList) in
                switch resullList {
                case .success(let list):
                    let viewModels = list.results.map(PlaceViewModel.init)
                    self?.viewController?.show(viewModels: viewModels)
                case .failure:
                    print("Error")
                }
        }
    }
    
    private func requestList() {
        self.locationRepository.requestLocation { [weak self] (resultLocation) in
            switch resultLocation {
            case .success(let location):
                self?.handleUserLocation(location)
            case .failure:
                print("Error")
            }
        }
    }
}

extension ListPresenter: ListTableViewControllerDelegate {
    func didSelectPlace(placeId: String) {
        self.router?.routeToDetails(with: placeId)
    }
}
