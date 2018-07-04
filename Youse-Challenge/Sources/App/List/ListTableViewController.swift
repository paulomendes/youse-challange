import UIKit
import JGProgressHUD

protocol ListTableViewControllerProtocol: ViewControllerType {
    var delegate: ListTableViewControllerDelegate? { get set }
    func show(viewModel: ListTableViewModel)
}

protocol ListTableViewControllerDelegate: class {
    func didSelectPlace(placeId: String)
    func retry()
}

final class ListTableViewController: UITableViewController, ListTableViewControllerProtocol {
    weak var delegate: ListTableViewControllerDelegate?
    private lazy var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Carregando"
        return hud
    }()
    
    private var viewModel: ListTableViewModel = .loading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
    }
    
    func show(viewModel: ListTableViewModel) {
        self.viewModel = viewModel
        self.handleViewModel()
    }
    
    private func handleViewModel() {
        
        switch self.viewModel.type {
        case .contentReady:
            self.hud.dismiss()
            self.tableView.reloadData()
        case .loading:
            self.hud.show(in: self.view)
        case .error:
            self.hud.dismiss()
            self.showAlertForRetry()
        }
        
    }
    
    private func showAlertForRetry() {
        UIAlertController.showErrorAlert(in: self) {
            self.delegate?.retry()
        }
    }
}

extension ListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: "list-cell") as! ListCell
        cell.show(viewModel: self.viewModel.places[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModel.places[indexPath.row]
        self.delegate?.didSelectPlace(placeId: viewModel.placeId)
    }
}
