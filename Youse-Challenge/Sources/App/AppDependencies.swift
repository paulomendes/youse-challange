import UIKit
import INTULocationManager
import Moya
import SwiftResolver

struct DefaultDependencies {
    let window: UIWindow
    let storyboard: UIStoryboard
    let plugins: [PluginType] = {
        return [NetworkLoggerPlugin(verbose: true)]
    }()
}

final class AppDependencies {
    private let container = Container()
    
    init(dependencies: DefaultDependencies) {
        self.registerWith(dependencies)
    }
}

extension AppDependencies {
    func resolve<T>() -> T {
        return self.container.resolve()
    }
    
    func resolve<T, Specifier>(_ specifier: Specifier) -> T {
        return self.container.resolve(specifier)
    }
}

extension AppDependencies {
    private func registerWith(_ dependencies: DefaultDependencies) {
        self.container.register(scope: .shared) { MoyaProvider<MultiTarget>(plugins: dependencies.plugins) }
        self.container.register { INTULocationManager() }
        
        self.container.register { RequestProvider(provider: $0) }.as(RequestProviderType.self)
        self.container.register(scope: .shared) { GooglePlacesRepository(requestProvider: $0) }.as(GooglePlacesRepositoryProtocol.self)
        self.container.register { LocationRepository(locationManager: $0) }.as(LocationRepositoryProtocol.self)
        
        self.container.register { AppModule(window: dependencies.window, listModule: $0) }
        self.container.register { ListModule(detailsModule: $0,
                                             googlePlacesRepository: $1,
                                             locationRepository: $2,
                                             storyboard: dependencies.storyboard) }
            .as(ListModuleProtocol.self)
        self.container.register { DetailsModule(googlePlacesRepository: $0,
                                                storyboard: dependencies.storyboard) }.as(DetailsModuleProtocol.self)
    }
}
