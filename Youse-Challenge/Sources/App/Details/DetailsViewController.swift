import UIKit

protocol DetailsViewControllerDelegate: class {
    func viewDidDisappear()
}

protocol DetailsViewControllerProtocol: ViewControllerType {}

final class DetailsViewController: UITableViewController, DetailsViewControllerProtocol {
    weak var delegate: DetailsViewControllerDelegate?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.viewDidDisappear()
    }
    
    deinit {
        print("deinit")
    }
}
