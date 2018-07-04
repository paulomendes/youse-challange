import UIKit
@testable import Youse_Challenge

final class FauxDetailsViewController: DetailsViewControllerProtocol {
    func asViewController() -> UIViewController {
        return UIViewController()
    }
    
    func show(viewModel: DetailsViewModel) {}
}

final class FauxListPresenter: ListPresenterProtocol {
    func start() {}
}

final class FauxDetailsRouter: DetailsRouterProtocol {
    var calledStart: (() -> Void)?
    var children: [Router] = []
    var viewController: DetailsViewControllerProtocol {
        return FauxDetailsViewController()
    }
    
    var delegate: DetailsRouterDelegate?
    
    func detachChild() {}
    
    func start() {
        self.calledStart?()
    }
}

final class FauxDetailsModule: DetailsModuleProtocol {
    var calledBuilder: ((_ router: FauxDetailsRouter) -> Void)?
    func build(placeId: String) -> DetailsRouterProtocol {
        let router = FauxDetailsRouter()
        self.calledBuilder?(router)
        return router
    }
}
