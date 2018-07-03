import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class PlaceDetailTests: QuickSpec {
    override func spec() {
        describe("When dealing with PlaceDetai deserealization") {
            it("should parse json correctly") {
                let details = PlaceDetail.stubbed(from: "place-details")
                expect(details.formattedAddress).to(equal("R. Flórida, 1758 - Cidade Monções, São Paulo - SP, 04565-001, Brasil"))
                expect(details.formattedPhoneNumber).to(equal("(11) 5102-2633"))
                expect(details.placeId).to(equal("ChIJeaz_VMtQzpQRB0m13mdHZFw"))
                expect(details.name).to(equal("KUMHO TIRE DO BRASIL COMERCIAL LTDA."))
                expect(details.reviews.count).to(equal(5))
                expect(details.location.latitude).to(beCloseTo(-23.60700659999999))
                expect(details.location.longitude).to(beCloseTo(-46.6947388))
            }
        }
    }
}
