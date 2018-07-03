import UIKit

protocol DetailsModuleProtocol {
    func build(placeId: String) -> DetailsRouterProtocol
}

final class DetailsModule: DetailsModuleProtocol {
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol
    private let storyboard: UIStoryboard
    
    init(googlePlacesRepository: GooglePlacesRepositoryProtocol,
         storyboard: UIStoryboard) {
        self.googlePlacesRepository = googlePlacesRepository
        self.storyboard = storyboard
    }
    
    func build(placeId: String) -> DetailsRouterProtocol {
        let viewController = self.storyboard
            .instantiateViewController(withIdentifier: "DetailsTableViewController")
            as! DetailsViewController
        
        let presenter = DetailsPresenter(googlePlacesRepository: googlePlacesRepository,
                                         placeId: placeId)
        let router = DetailsRouter(presenter: presenter,
                                   viewController: viewController)
        
        viewController.delegate = presenter
        presenter.router = router
        presenter.viewController = viewController
        
        return router
    }
}
