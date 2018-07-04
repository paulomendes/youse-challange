import UIKit

protocol ViewControllerType: class {
    func asViewController() -> UIViewController
}

extension ViewControllerType where Self: UIViewController {
    func asViewController() -> UIViewController {
        return self
    }
}

extension UIViewController {
    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewControllable: ViewControllerType, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.present(viewControllable.asViewController(), animated: animated, completion: completion)
    }
}
