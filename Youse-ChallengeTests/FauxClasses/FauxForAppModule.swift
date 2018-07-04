import Foundation
import UIKit
@testable import Youse_Challenge


final class FauxViewController: ViewControllerType {
    func asViewController() -> UIViewController { return UIViewController() }
}

final class FauxListRouter: ListRouterProtocol {
    var children: [Router] = []
    var calledStart: (() -> Void)?
    func start() {
        self.calledStart?()
    }
    var viewController: ViewControllerType { return FauxViewController() }
    func routeToDetails(with placeId: String) {}
}

final class FauxListModule: ListModuleProtocol {
    var calledBuild: ((_ router: FauxListRouter) -> Void)?
    func build() -> ListRouterProtocol {
        let router = FauxListRouter()
        self.calledBuild?(router)
        return router
    }
}
