import Quick
import Nimble
import CoreLocation
import Moya
@testable import Youse_Challenge

final class GooglePlacesTargetTests: QuickSpec {
    override func spec() {
        it("should have correct configuration for GooglePlaces List API") {
            let anyLocation = CLLocationCoordinate2D(latitude: -23.6077583,
                                                     longitude: -46.697316199)
            let placesParameters = PlacesParameters(location: anyLocation,
                                                    radius: 1000,
                                                    types: "car_repair")
            
            let target = GooglePlacesTarget.places(placesParameters)
            
            expect(target.urlPath).to(equal("place/nearbysearch/json"))
            let expectedPath = "place/nearbysearch/json?\(target.parameters.toParameters())"
            expect(target.path).to(equal(expectedPath))
        }
    }
}
