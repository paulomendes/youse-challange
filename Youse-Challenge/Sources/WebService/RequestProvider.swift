import Moya

enum Result<E> {
    case success(E)
    case failure(Error)
}
protocol RequestProviderType {
    func request<Model: Decodable>(target: Moya.TargetType, completion: @escaping (_ result: Result<Model>) -> Void )
}

final class RequestProvider: RequestProviderType {
    private let provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    func request<Model: Decodable>(target: Moya.TargetType, completion: @escaping (_ result: Result<Model>) -> Void ) {
        let target = MultiTarget(target)
        self.provider.request(target) { (result) in
            do {
                let response = try result.dematerialize().filterSuccessfulStatusCodes()
                let models = try response.map(Model.self)
                completion(Result.success(models))
            } catch MoyaError.statusCode {
                completion(Result.failure(YCError.requestError))
            } catch {
                completion(Result.failure(YCError.serializationError))
            }
        }
    }
}
