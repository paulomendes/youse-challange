import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class DetailsModuleTests: QuickSpec {
    override func spec() {
        it("should build correctly") {
            let googleRepository = FauxGooglePlacesRepository()
            let storyboard = UIStoryboard(name: "MainFlow", bundle: nil)
            
            let detailsModule = DetailsModule(googlePlacesRepository: googleRepository,
                                              storyboard: storyboard)
            
            let router = detailsModule.build(placeId: "placeid")
            expect(router).to(beAKindOf(DetailsRouter.self))
            expect(router.viewController).to(beAKindOf(DetailsViewController.self))
        }
    }
}
