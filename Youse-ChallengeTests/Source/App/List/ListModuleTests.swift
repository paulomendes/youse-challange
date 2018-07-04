import Quick
import Nimble
import UIKit
@testable import Youse_Challenge

final class ListModuleTests: QuickSpec {
    override func spec() {
        it("should build correctly") {
            let detailsModule = FauxDetailsModule()
            let googleRepository = FauxGooglePlacesRepository()
            let locationRepository = FauxLocationRepository()
            let storyboard = UIStoryboard(name: "MainFlow", bundle: nil)
            
            let listModule = ListModule(detailsModule: detailsModule,
                                        googlePlacesRepository: googleRepository,
                                        locationRepository: locationRepository,
                                        storyboard: storyboard)
            let router = listModule.build()
            expect(router).to(beAKindOf(ListRouter.self))
            expect(router.viewController).to(beAKindOf(ListTableViewController.self))
        }
    }
}
