import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import Youse_Challenge

final class MockDetailsViewControllerDelegate: DetailsViewControllerDelegate {
    var calledViewDidDisappear: (() -> Void)?
    func viewDidDisappear() {
        self.calledViewDidDisappear?()
    }
    
    func retry() {}
}

final class DetailsViewControllerTests: QuickSpec {
    var detailsViewController: DetailsViewController!
    var detailsPresenter: DetailsPresenter!
    var detailsDelegate: MockDetailsViewControllerDelegate!
    
    override func spec() {
        beforeSuite {
            let storyboard = UIStoryboard(name: "MainFlow", bundle: Bundle.main)
            self.detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsViewController
            UIApplication.shared.keyWindow!.rootViewController = self.detailsViewController
            self.detailsViewController.preloadView()
            let repository = FauxGooglePlacesRepository(placeDetails: true)
            let placeId = "ChIJeaz_VMtQzpQRB0m13mdHZFw"
            let presenter = DetailsPresenter(googlePlacesRepository: repository, placeId: placeId)
            self.detailsDelegate = MockDetailsViewControllerDelegate()
            self.detailsViewController.delegate = self.detailsDelegate
            presenter.viewController = self.detailsViewController
            self.detailsPresenter = presenter
        }
        
        it("should render correctly after a success request") {
            self.detailsPresenter.start()
            expect(self.detailsViewController.view).to(haveValidSnapshot())
        }
        
        it("should call viewDidDisappear presenter delegate method prior dismiss") {
            let viewDidDisappearExpectation = QuickSpec.expectation(description: "viewDidDisappear called")
            
            self.detailsDelegate.calledViewDidDisappear = {
                viewDidDisappearExpectation.fulfill()
            }
            
            self.detailsViewController.viewDidDisappear(true)
            QuickSpec.waitForExpectationsDefaultTimeout()
        }
    }
}
