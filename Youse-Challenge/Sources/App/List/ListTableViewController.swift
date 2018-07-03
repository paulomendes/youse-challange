import UIKit

protocol ListTableViewControllerProtocol: ViewControllerType {
    var delegate: ListTableViewControllerDelegate? { get set }
    func show(viewModels: [PlaceViewModel])
}

protocol ListTableViewControllerDelegate: class {
    func didSelectPlace(placeId: String)
}

final class ListTableViewController: UITableViewController, ListTableViewControllerProtocol {
    weak var delegate: ListTableViewControllerDelegate?
    
    private var viewModels: [PlaceViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
    }
    
    func show(viewModels: [PlaceViewModel]) {
        self.viewModels = viewModels
    }
}

extension ListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: "list-cell") as! ListCell
        cell.show(viewModel: self.viewModels[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModels[indexPath.row]
        self.delegate?.didSelectPlace(placeId: viewModel.placeId)
    }
}
