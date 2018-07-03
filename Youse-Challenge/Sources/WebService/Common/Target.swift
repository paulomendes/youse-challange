import Moya

protocol Target: TargetType {
    var urlPath: String { get }
    var parameters: Parameterizable { get }
}

extension Target {
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/")!
    }
    
    var path: String {
        return self.urlPath
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: self.parameters.toParameters(),
                                  encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
