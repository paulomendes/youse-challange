import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import Youse_Challenge

extension UIViewController {
    func preloadView() {
        let _ = view
    }
}

final class MockListTableViewControllerDelegate : ListTableViewControllerDelegate {
    var calledDidSelectPlace: ((_ placeId: String) -> Void)?
    func didSelectPlace(placeId: String) {
        self.calledDidSelectPlace?(placeId)
    }
}

final class ListTableViewControllerTests: QuickSpec {
    var listTableViewController: ListTableViewController!
    var listPresenter: ListPresenter!
    var viewControllerDelegate: MockListTableViewControllerDelegate!
    
    override func spec() {
        beforeSuite {
            let storyboard = UIStoryboard(name: "MainFlow", bundle: Bundle.main)
            self.viewControllerDelegate = MockListTableViewControllerDelegate()
            self.listTableViewController = storyboard.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
            UIApplication.shared.keyWindow!.rootViewController = self.listTableViewController
            self.listTableViewController.preloadView()
            self.listTableViewController.delegate = self.viewControllerDelegate
            let locationRepository = FauxLocationRepository(location: .anyLocation)
            let googlePlacesRepository = FauxGooglePlacesRepository(resultList: true)

            let presenter = ListPresenter(locationRepository: locationRepository,
                                          googlePlacesRepository: googlePlacesRepository)
            presenter.viewController = self.listTableViewController
            self.listPresenter = presenter
            
            
        }
        
        it("should render correctly after a success request") {
            self.listPresenter.start()
            expect(self.listTableViewController.view).to(haveValidSnapshot())
        }
        
        it("should call viewController correctly after select a row") {
            let delegateExpectaion = QuickSpec.expectation(description: "delegate call")
            
            self.viewControllerDelegate.calledDidSelectPlace = { placeId in
                expect(placeId).to(equal("ChIJeaz_VMtQzpQRB0m13mdHZFw"))
                delegateExpectaion.fulfill()
            }
            
            self.listTableViewController
                .tableView
                .delegate?
                .tableView!(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
            
            QuickSpec.waitForExpectationsDefaultTimeout()
        }
    }
}
