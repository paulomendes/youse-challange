import UIKit

protocol AppRouterProtocol: Router {
    func routeToList()
}

final class AppRouter: AppRouterProtocol {
    private let listModule: ListModuleProtocol
    private let window: UIWindow
    private let navigationController: UINavigationController
    var children: [Router] = []

    init(listModule: ListModuleProtocol,
         window: UIWindow,
         navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.listModule = listModule
    }
    
    func start() {
        self.routeToList()
    }
}

extension AppRouter {
    func routeToList() {
        let listRouter = self.listModule.build()
        listRouter.start()
        self.children.append(listRouter)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
        
        self.navigationController
            .show(listRouter.viewController.asViewController(), sender: nil)
    }
}
