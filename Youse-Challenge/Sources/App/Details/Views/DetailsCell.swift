import UIKit

final class DetailsCell: UITableViewCell {
    @IBOutlet weak var info: UITextView!

    func show(info: String) {
        self.info.text = info
    }
}
