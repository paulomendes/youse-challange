import UIKit

final class ReviewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    
    func show(viewModel: ReviewViewModel) {
        self.name.text = viewModel.name
        self.rating.text = viewModel.rating
        self.reviewText.text = viewModel.reviewText
    }
}
