import UIKit

protocol ListModuleProtocol {
    func build() -> ListRouterProtocol
}

final class ListModule: ListModuleProtocol {
    private let detailsModule: DetailsModuleProtocol
    private let googlePlacesRepository: GooglePlacesRepositoryProtocol
    private let locationRepository: LocationRepositoryProtocol
    private let storyboard: UIStoryboard
    
    init(detailsModule: DetailsModuleProtocol,
         googlePlacesRepository: GooglePlacesRepositoryProtocol,
         locationRepository: LocationRepositoryProtocol,
         storyboard: UIStoryboard) {
        self.detailsModule = detailsModule
        self.googlePlacesRepository = googlePlacesRepository
        self.locationRepository = locationRepository
        self.storyboard = storyboard
    }
    
    func build() -> ListRouterProtocol {
        let viewController = self.storyboard
            .instantiateViewController(withIdentifier: "ListTableViewController")
            as! ListTableViewController
        
        let presenter = ListPresenter(locationRepository: locationRepository,
                                      googlePlacesRepository: googlePlacesRepository)
        let router = ListRouter(detailsModule: self.detailsModule,
                                presenter: presenter,
                                viewController: viewController)
        
        viewController.delegate = presenter
        presenter.router = router
        presenter.viewController = viewController
        
        return router
    }
}
