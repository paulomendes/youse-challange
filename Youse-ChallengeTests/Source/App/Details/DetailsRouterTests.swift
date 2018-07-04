import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class FauxDetailsPresenter: DetailsPresenterProtocol {
    var calledStart: (() -> Void)?
    func start() {
        self.calledStart?()
    }
}

final class MockDetailsRouterDelegate: DetailsRouterDelegate {
    var calledDetachChild: ((_ sender: DetailsRouterProtocol) -> Void)?
    func detachChild(_ sender: DetailsRouterProtocol) {
        self.calledDetachChild?(sender)
    }
}

final class DetailsRouterTests: QuickSpec {
    let detailsRouterDelegate = MockDetailsRouterDelegate()
    override func spec() {
        it("should start presenter after his own start") {
            let detailsPresenter = FauxDetailsPresenter()
            let viewController = FauxDetailsViewController()
            let startExpectation = QuickSpec.expectation(description: "called start")
            let detailsRouter = DetailsRouter(presenter: detailsPresenter,
                                              viewController: viewController)
            
            detailsPresenter.calledStart = {
                startExpectation.fulfill()
            }
            
            detailsRouter.start()
            
            QuickSpec.waitForExpectationsDefaultTimeout()
        }
        
        it("should call delegate detachChild after a deatchChild function call") {
            let detailsPresenter = FauxDetailsPresenter()
            let viewController = FauxDetailsViewController()
            let detachExpectation = QuickSpec.expectation(description: "called detach")
            let detailsRouter = DetailsRouter(presenter: detailsPresenter,
                                              viewController: viewController)
            detailsRouter.delegate = self.detailsRouterDelegate
            
            self.detailsRouterDelegate.calledDetachChild = { sender in
                expect(sender).to(beAKindOf(DetailsRouter.self))
                detachExpectation.fulfill()
            }
            
            detailsRouter.detachChild()
            
            QuickSpec.waitForExpectationsDefaultTimeout()
        }
    }
}
