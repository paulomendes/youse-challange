import UIKit
import MapKit
import CoreLocation

final class MapHeaderView: MKMapView {
    func show(viewModel: DetailsViewModel) {
        self.camera = viewModel.mapCamera
        self.addAnnotation(viewModel.mapAnnotation)
        self.isHidden = false
    }
}
