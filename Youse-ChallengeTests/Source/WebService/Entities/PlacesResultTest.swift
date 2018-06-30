import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlacesResultTest: QuickSpec {
    override func spec() {
        describe("When dealing with PlacesResult deserealization") {
            it("should parse json correctly") {
                let placesResult = PlacesResult.stubbed(from: "nearby-result-entry")
                
                expect(placesResult.name).to(equal("KUMHO TIRE DO BRASIL COMERCIAL LTDA."))
                expect(placesResult.icon.absoluteString).to(equal("https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png"))
                expect(placesResult.placeId).to(equal("ChIJeaz_VMtQzpQRB0m13mdHZFw"))
                expect(placesResult.vicinity).to(equal("Rua Flórida, 1758 - Cidade Monções, São Paulo"))
            }
        }
    }
}
