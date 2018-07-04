import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class ListPresenterTests: QuickSpec {
    override func spec() {
        describe("during the start") {
            it("should request position and after that request a list of car repair places") {
                let locationRepository = FauxLocationRepository(location: .anyLocation)
                let googlePlacesRepository = FauxGooglePlacesRepository()
                let requestLocationExpectation = QuickSpec.expectation(description: "called request location")
                let requestCarRepairList = QuickSpec.expectation(description: "called request car repair list")
                
                locationRepository.calledRequestLocation = {
                    requestLocationExpectation.fulfill()
                }
                
                googlePlacesRepository.calledRepairList = {
                    requestCarRepairList.fulfill()
                }
                
                let presenter = ListPresenter(locationRepository: locationRepository,
                                              googlePlacesRepository: googlePlacesRepository)
                
                presenter.start()
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should call show view model in viewcontroller for a success response") {
                let locationRepository = FauxLocationRepository(location: .anyLocation)
                let googlePlacesRepository = FauxGooglePlacesRepository(resultList: true)
                let viewController = FauxListTableViewController()
                let showExpectation = QuickSpec.expectation(description: "called show view model")
                
                viewController.calledShow = { viewModels in
                    expect(viewModels).to(beAKindOf([PlaceViewModel].self))
                    showExpectation.fulfill()
                }
                
                let presenter = ListPresenter(locationRepository: locationRepository,
                                              googlePlacesRepository: googlePlacesRepository)
                presenter.viewController = viewController
                presenter.start()
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
        
        describe("after a place selection") {
            it("should route to details with correct placeid") {
                let locationRepository = FauxLocationRepository()
                let googlePlacesRepository = FauxGooglePlacesRepository()
                let router = FauxListRouter()
                let routeToDetailsExpectation = QuickSpec.expectation(description: "route to details expectation")
                
                router.calledRouteToDetails = { placeId in
                    expect(placeId).to(equal("placeid"))
                    routeToDetailsExpectation.fulfill()
                }
                
                let presenter = ListPresenter(locationRepository: locationRepository,
                                              googlePlacesRepository: googlePlacesRepository)
                presenter.router = router
                presenter.didSelectPlace(placeId: "placeid")
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
    }
}
