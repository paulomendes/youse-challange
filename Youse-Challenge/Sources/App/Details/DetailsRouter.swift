import Foundation

protocol DetailsRouterDelegate: class {
    func detachChild(_ sender: DetailsRouterProtocol)
}

protocol DetailsRouterProtocol: Router {
    var viewController: DetailsViewControllerProtocol { get }
    var delegate: DetailsRouterDelegate? { get set }
    func detachChild()
}

final class DetailsRouter: DetailsRouterProtocol {
    var children: [Router] = []
    weak var delegate: DetailsRouterDelegate?
    
    private let presenter: DetailsPresenterProtocol
    let viewController: DetailsViewControllerProtocol
    
    init(presenter: DetailsPresenterProtocol,
         viewController: DetailsViewControllerProtocol) {
        self.presenter = presenter
        self.viewController = viewController
    }

    func start() {
        self.presenter.start()
    }
    
    func detachChild() {
        self.delegate?.detachChild(self)
    }
}
