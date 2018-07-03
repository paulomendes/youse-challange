import UIKit

final class ListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    func show(viewModel: PlaceViewModel) {
        self.nameLabel.text = viewModel.name
        self.addressLabel.text = viewModel.address
        self.rating.text = viewModel.rating
    }
}
