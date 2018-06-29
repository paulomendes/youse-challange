import Foundation

protocol Parameterizable {
    func buildParameters() -> [AnyHashable: Any]
    func toParameters() -> String
}

extension Parameterizable {
    func toParameters() -> String {
        var parameters = self.buildParameters()
        parameters["key"] = GoogleAPIConfiguration.apiKey
        
        return parameters.compactMap {
            return "\($0)=\($1)"
        }.joined(separator: "&")
    }
}

