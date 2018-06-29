import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlacesParametersTests: QuickSpec {
    override func spec() {
        it("should build parameters correctly with correct google api key") {
            let params = PlacesParameters(location: CLLocationCoordinate2D(latitude: -23.6077583,
                                                                           longitude: -46.697316199),
                                          radius: 1000,
                                          types: "car_repair")
            expect(params.toParameters()).to(contain("key=AIzaSyD7MClEvz4SPpixisK7cNtas5F06XQdLT8"))
            expect(params.toParameters()).to(contain("location=-23.6077583,-46.6973162"))
            expect(params.toParameters()).to(contain("radius=1000"))
            expect(params.toParameters()).to(contain("types=car_repair"))
            
            let parameters = params.toParameters().split(separator: "&")
            expect(parameters.count).to(equal(4))
        }
    }
}
