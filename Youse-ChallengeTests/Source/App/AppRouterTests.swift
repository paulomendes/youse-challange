import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class FauxAppNavigationViewController: UINavigationController {
    var calledShow: (() -> Void)?
    override func show(_ vc: UIViewController, sender: Any?) {
        self.calledShow?()
    }
}

final class AppRouterTests: QuickSpec {
    override func spec() {
        it("it should route correctly to list after start") {
            let listModule = FauxListModule()
            let buildExpectation = QuickSpec.expectation(description: "called build")
            let startExpectation = QuickSpec.expectation(description: "called router start")
            let showExpectation = QuickSpec.expectation(description: "called show")
            
            listModule.calledBuild = { router in
                buildExpectation.fulfill()
                router.calledStart = {
                    startExpectation.fulfill()
                }
            }
            
            let window = UIWindow(frame: CGRect.zero)
            let viewController = FauxAppNavigationViewController()
            viewController.calledShow = {
                showExpectation.fulfill()
            }
            let appRouter = AppRouter(listModule: listModule,
                                      window: window,
                                      navigationController: viewController)
            appRouter.start()
            expect(window.rootViewController!).to(beAKindOf(UINavigationController.self))
            
            QuickSpec.waitForExpectationsDefaultTimeout()
        }
    }
}
