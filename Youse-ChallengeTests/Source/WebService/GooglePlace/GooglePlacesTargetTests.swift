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
            let placesParameters = CarRepairParameters(location: anyLocation)
            let target = GooglePlacesTarget.places(placesParameters)
            let parameters = target.parameters.toParameters()
            
            expect(target.urlPath).to(equal("place/nearbysearch/json"))
            expect(parameters["location"] as? String).to(equal(anyLocation.commaNotation()))
            expect(parameters["radius"] as? Int).to(equal(1000))
            expect(parameters["types"] as? String).to(equal("car_repair"))
            expect(parameters["key"]).toNot(beNil())
        }
        
        it("should have correct configuration for GooglePlaces Details Place API") {
            let placeId = "PlaceID"
            let placeParameter = PlaceDetailsParameters(placeId: placeId)
            let target = GooglePlacesTarget.placeDetails(placeParameter)
            let parameters = target.parameters.toParameters()
            
            expect(target.urlPath).to(equal("place/details/json"))
            expect(parameters["place_id"] as? String).to(equal(placeId))
            expect(parameters["key"]).toNot(beNil())
        }
    }
}
