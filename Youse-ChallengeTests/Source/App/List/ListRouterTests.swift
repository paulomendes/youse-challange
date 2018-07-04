import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class FauxListTableViewController: ListTableViewControllerProtocol {
    var delegate: ListTableViewControllerDelegate?
    var calledPush: ((_ viewController: UIViewController, _ animated: Bool) -> Void)?
    func show(viewModels: [PlaceViewModel]) {}
    
    func asViewController() -> UIViewController {
        let viewController = MockViewController()
        viewController.calledPush = calledPush
        return viewController
    }
}

final class ListRouterTests: QuickSpec {
    override func spec() {
        it("should route to details correctly and start presenter") {
            let buildExpectation = QuickSpec.expectation(description: "called build")
            let startExpectation = QuickSpec.expectation(description: "called router start")
            let pushExpectation = QuickSpec.expectation(description: "called push")
            
            let detailsModule = FauxDetailsModule()
            detailsModule.calledBuilder = { router in
                buildExpectation.fulfill()
                router.calledStart = {
                    startExpectation.fulfill()
                }
            }
            let listPresenter = FauxListPresenter()
            let viewController = FauxListTableViewController()
            viewController.calledPush = { viewController, animated in
                expect(viewController).to(beAKindOf(UIViewController.self))
                expect(animated).to(beTrue())
                pushExpectation.fulfill()
            }

            let listRouter = ListRouter(detailsModule: detailsModule,
                                        presenter: listPresenter,
                                        viewController: viewController)
            listRouter.routeToDetails(with: "placeid")

            QuickSpec.waitForExpectationsDefaultTimeout()
        }
    }
}
