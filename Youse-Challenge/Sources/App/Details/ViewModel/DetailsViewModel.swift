import UIKit
import CoreLocation
import MapKit

enum DetailsViewModelSections: Int {
    case info
    case reviews
}

extension DetailsViewModelSections {
    var title: String {
        switch self {
        case .info:
            return "Informações"
        case .reviews:
            return "Avaliações"
        }
    }
}

struct DetailsViewModel {
    private let type: ViewModelType
    private let placeDetails: PlaceDetails
    
    var name: String {
        return self.placeDetails.name
    }
    
    var info: String {
        var info = self.placeDetails.formattedAddress
        if let phoneNumber = self.placeDetails.formattedPhoneNumber {
            info.append("\n\n\(phoneNumber)")
        }
        return info
    }
    
    var numberOfSections: Int {
        if self.placeDetails.reviews != nil {
            return 2
        } else {
            return 1
        }
    }
    
    var reviews: [ReviewViewModel]? {
        return self.placeDetails.reviews?.map(ReviewViewModel.init)
    }
    
    var mapCamera: MKMapCamera {
        return MKMapCamera(lookingAtCenter: self.placeDetails.location,
                           fromDistance: 1000,
                           pitch: 0,
                           heading: 0)
    }
    
    var mapAnnotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.placeDetails.location
        annotation.title = self.placeDetails.name
        return annotation
    }
    
    private var numberOfReviews: Int {
        guard let reviews = self.placeDetails.reviews else { return 0 }
        return reviews.count
    }
    
    func numberOfRows(for section: DetailsViewModelSections) -> Int {
        switch section {
        case .info:
            return 1
        case .reviews:
            return self.numberOfReviews
        }
    }
    
    init(placeDetails: PlaceDetails) {
        self.placeDetails = placeDetails
        self.type = .contentReady
    }
}
