import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlacesParametersTests: QuickSpec {
    override func spec() {
        it("should build parameters correctly with correct google api key") {
            let anyLocation = CLLocationCoordinate2D(latitude: -23.6077583,
                                                     longitude: -46.697316199)
            let parameter = CarRepairParameters(location: anyLocation).buildParameters()

            expect(parameter["location"] as? String).to(equal(anyLocation.commaNotation()))
            expect(parameter["radius"] as? Int).to(equal(1000))
            expect(parameter["types"] as? String).to(equal("car_repair"))
        }
    }
}
