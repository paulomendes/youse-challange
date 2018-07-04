import UIKit

extension UIAlertController {
    static func showErrorAlert(in view: UIViewController,
                               withCancel: Bool = false,
                               completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "Ocorreu um erro",
                                      message: "Verifique sua conexão com a internet e tente novamente",
                                      preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Tentar Novamente",
                                        style: .default) { _ in
            completion()
        }
        
        if withCancel {
            let cancel = UIAlertAction(title: "Cancelar", style:.cancel)
            alert.addAction(cancel)
        }
        
        alert.addAction(retryAction)
        view.present(alert, animated: true)
    }
}
