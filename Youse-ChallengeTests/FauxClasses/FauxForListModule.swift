import UIKit
@testable import Youse_Challenge

final class FauxDetailsViewController: DetailsViewControllerProtocol {
    var calledShow: ((_ viewModel: DetailsViewModel) -> Void)?
    var calledError: (() -> Void)?
    func asViewController() -> UIViewController {
        return UIViewController()
    }
    
    func show(viewModel: DetailsViewModel) {
        self.calledShow?(viewModel)
    }
    
    func showError() {
        self.calledError?()
    }
    func loading() {}
}

final class FauxListPresenter: ListPresenterProtocol {
    func start() {}
}

final class FauxDetailsRouter: DetailsRouterProtocol {
    var calledStart: (() -> Void)?
    var calledDetachChild: (() -> Void)?
    var children: [Router] = []
    var viewController: DetailsViewControllerProtocol {
        return FauxDetailsViewController()
    }
    
    var delegate: DetailsRouterDelegate?
    
    func detachChild() {
        self.calledDetachChild?()
    }
    
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
