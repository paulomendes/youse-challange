import Foundation
import RxSwift

protocol DetailsPresenterProtocol: Presenter {}

final class DetailsPresenter: DetailsPresenterProtocol {
    weak var viewController: DetailsViewControllerProtocol?
    weak var router: DetailsRouterProtocol?
    
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol
    private let placeId: String
    private let disposeBag = DisposeBag()
    
    init(googlePlacesRepository: GooglePlacesRepositoryProtocol,
         placeId: String) {
        self.googlePlacesRepository = googlePlacesRepository
        self.placeId = placeId
    }
    
    func start() {
        self.googlePlacesRepository
            .getCarRepairDetails(with: PlaceDetailsParameters(placeId: self.placeId))
            .subscribe { [weak self] single in
                switch single {
                case .success(let placeDetails):
                    let viewModel = DetailsViewModel(placeDetails: placeDetails)
                    self?.viewController?.show(viewModel: viewModel)
                case .error:
                    print("Error")
                }
            }.disposed(by: self.disposeBag)
    }
}

extension DetailsPresenter: DetailsViewControllerDelegate {
    func viewDidDisappear() {
        self.router?.detachChild()
    }
}
