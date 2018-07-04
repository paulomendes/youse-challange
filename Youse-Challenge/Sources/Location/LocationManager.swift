import INTULocationManager

protocol LocationManagerProtocol {
    @discardableResult func requestLocation(block: @escaping  INTULocationRequestBlock) -> INTULocationRequestID
}

final class LocationManager: LocationManagerProtocol {
    private let intuLocationManager: INTULocationManager
    
    init(intuLocationManager: INTULocationManager) {
        self.intuLocationManager = intuLocationManager
    }
    
    func requestLocation(block: @escaping  INTULocationRequestBlock) -> INTULocationRequestID {
        return self.intuLocationManager.requestLocation(withDesiredAccuracy: .block,
                                                        timeout: 5.0,
                                                        delayUntilAuthorized: true,
                                                        block: block)
    }
}
