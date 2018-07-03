import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appRouter: AppRouterProtocol?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "MainFlow", bundle: nil)
        
        let dependencies = AppDependencies(dependencies: DefaultDependencies(window: window, storyboard: storyboard))
        let app = dependencies.resolve() as AppModule
        
        let appRouter = app.build()
 
        appRouter.start()
        self.appRouter = appRouter

        return true
    }
}
