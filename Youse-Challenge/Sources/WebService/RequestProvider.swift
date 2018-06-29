import Moya
import RxSwift

protocol RequestProviderType {
    func request<Model: Decodable>(target: Moya.TargetType) -> Single<Model>
    func request(target: Moya.TargetType) -> Single<Response>
}

extension RequestProviderType {
    func request<Model: Decodable>(_ type: Model.Type, target: Moya.TargetType) -> Single<Model> {
        return self.request(target: target)
    }
}

private enum RequestScheduler {
    static let scheduler = ConcurrentDispatchQueueScheduler(queue: RequestScheduler.queue)
    static let queue = DispatchQueue(label: "br.youse.requestProvider.serializationQueue", attributes: .concurrent)
}

final class RequestProvider: RequestProviderType {
    private let provider: MoyaProvider<MultiTarget>
    private let queue: ImmediateSchedulerType
    
    init(provider: MoyaProvider<MultiTarget>,
         queue: ImmediateSchedulerType = RequestScheduler.scheduler) {
        self.provider = provider
        self.queue = queue
    }
    
    func request<Model: Decodable>(target: Moya.TargetType) -> Single<Model> {
        return self.request(target: target)
            .subscribeOn(self.queue)
            .map { response in
                do {
                    return try response.map(Model.self)
                } catch {
                    throw YCError.serializationError
                }
        }
    }
    
    func request(target: Moya.TargetType) -> Single<Response> {
        let target = MultiTarget(target)
        return Observable.create({ (observer) -> Disposable in
            let token = self.provider.request(target) { (result) in
                do {
                    observer.onNext(try result.dematerialize().filterSuccessfulStatusCodes())
                    observer.onCompleted()
                } catch {
                    observer.onError(YCError.serializationError)
                }
            }
            return Disposables.create {
                token.cancel()
            }
        }).asSingle()
    }
}
