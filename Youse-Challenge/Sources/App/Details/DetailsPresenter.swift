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
    
    func start() {}
}

extension DetailsPresenter: DetailsViewControllerDelegate {
    func viewDidDisappear() {
        self.router?.detachChild()
    }
}
