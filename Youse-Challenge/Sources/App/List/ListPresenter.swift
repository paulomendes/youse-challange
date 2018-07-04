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
        self.viewController?.show(viewModel: .loading())
        self.requestList()
    }
    
    private func handleUserLocation(_ location: CLLocation) {
        self.googlePlacesRepository
            .getCarRepairList(with: CarRepairParameters(location: location.coordinate)) { [weak self] (resullList) in
                switch resullList {
                case .success(let list):
                    let viewModels = list.results.map(PlaceViewModel.init)
                    self?.viewController?.show(viewModel: .contentReady(with: viewModels))
                case .failure:
                    self?.viewController?.show(viewModel: .error())
                }
        }
    }
    
    private func requestList() {
        self.locationRepository.requestLocation { [weak self] (resultLocation) in
            switch resultLocation {
            case .success(let location):
                self?.handleUserLocation(location)
            case .failure:
                self?.viewController?.show(viewModel: .error())
            }
        }
    }
}

extension ListPresenter: ListTableViewControllerDelegate {
    func retry() {
        self.requestList()
    }
    
    func didSelectPlace(placeId: String) {
        self.router?.routeToDetails(with: placeId)
    }
}
