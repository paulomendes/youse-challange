import Quick
import Nimble
@testable import Youse_Challenge

final class PlaceViewModelTests: QuickSpec {
    override func spec() {
        it("should parse correctly from entity") {
            let place = PlacesResult.stubbed(from: "nearby-result-entry")
            let viewModel = PlaceViewModel(placeResult: place)
            
            expect(viewModel.address).to(equal("Rua Flórida, 1758 - Cidade Monções, São Paulo"))
            expect(viewModel.name).to(equal("KUMHO TIRE DO BRASIL COMERCIAL LTDA."))
            expect(viewModel.rating).to(equal("Avaliação: 2.1"))
            expect(viewModel.placeId).to(equal("ChIJeaz_VMtQzpQRB0m13mdHZFw"))
        }
    }
}
