import UIKit
import JGProgressHUD

//MARK: - Protocols Definitions

protocol DetailsViewControllerDelegate: class {
    func viewDidDisappear()
    func retry()
}

protocol DetailsViewControllerProtocol: ViewControllerType {
    func show(viewModel: DetailsViewModel)
    func showError()
    func loading()
}

//MARK: - DetailsViewController

final class DetailsViewController: UITableViewController, DetailsViewControllerProtocol {
    weak var delegate: DetailsViewControllerDelegate?

    @IBOutlet weak var mapTableHeaderView: MapHeaderView!
    
    private lazy var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Carregando"
        return hud
    }()
    
    private var viewModel: DetailsViewModel? = nil {
        didSet {
            self.tableView.reloadData()
            self.hud.dismiss()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.viewDidDisappear()
    }
    
    func show(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.navigationItem.title = viewModel.name
        self.mapTableHeaderView.show(viewModel: viewModel)
    }
    
    func loading() {
        self.hud.show(in: self.view)
    }
    
    func showError() {
        self.hud.dismiss()
        UIAlertController.showErrorAlert(in: self, withCancel: true) {
            self.delegate?.retry()
        }
    }
}

//MARK: - TableView Protocol Methods

extension DetailsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        guard let detailsSection = DetailsViewModelSections(rawValue: section) else { return 0 }
        return viewModel.numberOfRows(for: detailsSection)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let detailsSection = DetailsViewModelSections(rawValue: section) else {
            return nil
        }
        return detailsSection.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailsSection = DetailsViewModelSections(rawValue: indexPath.section) else {
            fatalError("all sections should be implemented")
        }
        switch detailsSection {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "details-cell") as! DetailsCell
            guard let viewModel = self.viewModel else { return cell }
            
            cell.show(info: viewModel.info)
            return cell
        case .reviews:
            let cell = tableView.dequeueReusableCell(withIdentifier: "review-cell") as! ReviewCell
            guard let viewModel = self.viewModel?.reviews?[indexPath.row] else { return cell }
            
            cell.show(viewModel: viewModel)
            return cell
        }
    }
}
