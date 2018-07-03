import Quick
import Nimble
import MapKit
import CoreLocation
@testable import Youse_Challenge

final class DetailsViewModelTests: QuickSpec {
    override func spec() {
        it("should parse correctly from entity") {
            let placeDetail = PlaceDetails.stubbed(from: "place-details")
            let viewModel = DetailsViewModel(placeDetails: placeDetail)
            
            expect(viewModel.info).to(equal("R. Flórida, 1758 - Cidade Monções, São Paulo - SP, 04565-001, Brasil\n\n(11) 5102-2633"))
            expect(viewModel.name).to(equal("KUMHO TIRE DO BRASIL COMERCIAL LTDA."))
            expect(viewModel.numberOfSections).to(equal(2))
            expect(viewModel.reviews?.count).to(equal(5))
            
            let mapCamera = MKMapCamera(lookingAtCenter: placeDetail.location,
                                        fromDistance: 1000,
                                        pitch: 0,
                                        heading: 0)
            expect(viewModel.mapCamera).to(equal(mapCamera))
            expect(viewModel.mapAnnotation.coordinate.latitude).to(beCloseTo(placeDetail.location.latitude))
            expect(viewModel.mapAnnotation.coordinate.longitude).to(beCloseTo(placeDetail.location.longitude))
            expect(viewModel.mapAnnotation.title).to(equal("KUMHO TIRE DO BRASIL COMERCIAL LTDA."))
            expect(viewModel.numberOfRows(for: .info)).to(equal(1))
            expect(viewModel.numberOfRows(for: .reviews)).to(equal(5))
        }
    }
}
