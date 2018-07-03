import INTULocationManager

enum LocationError: Error {
    case waitingUserPermission
    case userDeniedLocationPermission
    case userRestrictedAccess
    case userDisabledLocationService
    case unknown
}

extension LocationError {
    init?(intuStatus: INTULocationStatus) {
        switch intuStatus {
        case .error: self = .unknown
        case .servicesNotDetermined: self = .waitingUserPermission
        case .servicesDenied: self = .userDeniedLocationPermission
        case .servicesRestricted: self = .userRestrictedAccess
        case .servicesDisabled: self = .userDisabledLocationService
        default:
            return nil
        }
    }
}

