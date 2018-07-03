import Foundation

protocol Parameterizable {
    func buildParameters() -> [String: Any]
    func toParameters() -> [String: Any]
}

extension Parameterizable {
    func toParameters() -> [String: Any] {
        var parameters = self.buildParameters()
        parameters["key"] = GoogleAPIConfiguration.apiKey
        return parameters
    }
}

