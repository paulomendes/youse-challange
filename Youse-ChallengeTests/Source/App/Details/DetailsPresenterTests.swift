import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class DetailsPresenterTests: QuickSpec {
    override func spec() {
        describe("during the start") {
            it("should request for a place detail") {
                let repository = FauxGooglePlacesRepository()
                let placeId = "ChIJeaz_VMtQzpQRB0m13mdHZFw"
                let calledCarRepairDetails = QuickSpec.expectation(description: "called details")
                
                repository.calledCarRepairDetails = {
                    calledCarRepairDetails.fulfill()
                }
                
                let presenter = DetailsPresenter(googlePlacesRepository: repository,
                                                 placeId: placeId)
                presenter.start()
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            it("should call show view model after a success request") {
                let repository = FauxGooglePlacesRepository(placeDetails: true)
                let placeId = "ChIJeaz_VMtQzpQRB0m13mdHZFw"
                let viewController = FauxDetailsViewController()
                let showExpectation = QuickSpec.expectation(description: "called show")
                
                viewController.calledShow = { viewModel in
                    expect(viewModel).to(beAKindOf(DetailsViewModel.self))
                    showExpectation.fulfill()
                }
                
                let presenter = DetailsPresenter(googlePlacesRepository: repository,
                                                 placeId: placeId)
                
                presenter.viewController = viewController
                presenter.start()
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should call detach after viewDidDisappear") {
                let repository = FauxGooglePlacesRepository(placeDetails: true)
                let placeId = "ChIJeaz_VMtQzpQRB0m13mdHZFw"
                let router = FauxDetailsRouter()
                let detachExpectation = QuickSpec.expectation(description: "called detach")
                
                router.calledDetachChild = {
                    detachExpectation.fulfill()
                }
                
                let presenter = DetailsPresenter(googlePlacesRepository: repository,
                                                 placeId: placeId)
                presenter.router = router
                presenter.viewDidDisappear()
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
    }
}
