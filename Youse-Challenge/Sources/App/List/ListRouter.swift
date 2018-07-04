import Foundation

protocol ListRouterProtocol: Router {
    var viewController: ViewControllerType { get }
    
    func routeToDetails(with placeId: String)
}

final class ListRouter: ListRouterProtocol {
    var children: [Router] = []
    
    let viewController: ViewControllerType
    private let detailsModule: DetailsModuleProtocol
    private let presenter: ListPresenterProtocol
    
    init(detailsModule: DetailsModuleProtocol,
         presenter: ListPresenterProtocol,
         viewController: ViewControllerType) {
        self.presenter = presenter
        self.detailsModule = detailsModule
        self.viewController = viewController
    }
    
    func start() {
        self.presenter.start()
    }
    
    func routeToDetails(with placeId: String) {
        let detailsRouter = self.detailsModule.build(placeId: placeId)
        detailsRouter.delegate = self
        self.children.append(detailsRouter)
        self.viewController
            .asViewController()
            .pushViewController(detailsRouter.viewController.asViewController())
        
        detailsRouter.start()
    }
}

extension ListRouter: DetailsRouterDelegate {
    func detachChild(_ sender: DetailsRouterProtocol) {
        if let index = self.children.index(where: { $0 === sender }) {
            self.children.remove(at: index)
        }
    }
}
