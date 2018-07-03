import UIKit

final class AppModule {
    private let listModule: ListModuleProtocol
    private let window: UIWindow
    
    init(window: UIWindow, listModule: ListModuleProtocol) {
        self.listModule = listModule
        self.window = window
    }
    
    func build() -> AppRouterProtocol {
        let appNavigationViewController = AppNavigationViewController()
        let router = AppRouter(listModule: self.listModule,
                               window: self.window,
                               navigationController: appNavigationViewController)
        return router
    }
}
