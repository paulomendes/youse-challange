import Foundation

protocol DetailsPresenterProtocol: Presenter {}

final class DetailsPresenter: DetailsPresenterProtocol {
    weak var viewController: DetailsViewControllerProtocol?
    weak var router: DetailsRouterProtocol?
    
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol
    private let placeId: String
    
    init(googlePlacesRepository: GooglePlacesRepositoryProtocol,
         placeId: String) {
        self.googlePlacesRepository = googlePlacesRepository
        self.placeId = placeId
    }
    
    func start() {
        self.requestDetails()
    }
    
    private func requestDetails() {
        self.viewController?.loading()
        self.googlePlacesRepository
            .getCarRepairDetails(with: PlaceDetailsParameters(placeId: self.placeId)) { [weak self] (result) in
                switch result {
                case .success(let placeDetails):
                    let viewModel = DetailsViewModel(placeDetails: placeDetails)
                    self?.viewController?.show(viewModel: viewModel)
                case .failure:
                    self?.viewController?.showError()
                }
        }
    }
}

extension DetailsPresenter: DetailsViewControllerDelegate {
    func retry() {
        self.requestDetails()
    }
    
    func viewDidDisappear() {
        self.router?.detachChild()
    }
}
