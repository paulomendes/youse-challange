import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlaceDetailParametersTests: QuickSpec {
    override func spec() {
        it("should build parameters correctly with correct google api key") {
            let placeDetailParameter = PlaceDetailsParameters(placeId: "placeid")
            let parameters = placeDetailParameter.buildParameters()
            
            expect(parameters["place_id"] as? String).to(equal("placeid"))
        }
    }
}
