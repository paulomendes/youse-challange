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
        let path = "\(self.urlPath)?\(self.parameters.toParameters())"
        return path
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
