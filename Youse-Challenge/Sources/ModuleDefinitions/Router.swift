import Foundation

protocol Router: class {
    var children: [Router] { get }

    func start()
}
