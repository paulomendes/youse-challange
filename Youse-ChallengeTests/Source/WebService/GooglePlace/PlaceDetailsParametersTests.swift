import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlaceDetailsParametersTests: QuickSpec {
    override func spec() {
        it("should build parameters correctly with correct google api key") {
            let params = PlaceDetailsParameters(placeId: "place_id_string")
            expect(params.toParameters()).to(contain("place_id=place_id_string"))
            expect(params.toParameters()).to(contain("key=AIzaSyD7MClEvz4SPpixisK7cNtas5F06XQdLT8"))
            
            let parameters = params.toParameters().split(separator: "&")
            expect(parameters.count).to(equal(2))
        }
    }
}
