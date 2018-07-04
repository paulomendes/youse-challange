import UIKit

final class MockNavigationViewController: UINavigationController {
    var calledPush: ((_ viewController: UIViewController, _ animated: Bool) -> Void)?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.calledPush?(viewController, animated)
    }
}

final class MockViewController: UIViewController {
    var calledPush: ((_ viewController: UIViewController, _ animated: Bool) -> Void)?
    override var navigationController: UINavigationController? {
        let navigationViewController = MockNavigationViewController()
        navigationViewController.calledPush = self.calledPush
        return navigationViewController
    }
}

