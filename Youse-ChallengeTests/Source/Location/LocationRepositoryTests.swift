import Quick
import Nimble
import INTULocationManager
import RxSwift
@testable import Youse_Challenge

final class FauxLocationManager: LocationManagerProtocol {
    var cancelLocationCall: (()->Void)?
    
    private let returnStatus: INTULocationStatus
    private let location: CLLocationCoordinate2D?
    
    init(returnStatus: INTULocationStatus = .success, location: CLLocationCoordinate2D? = .anyLocation) {
        self.returnStatus = returnStatus
        self.location = location
    }
    
    func requestLocation(block: @escaping INTULocationRequestBlock) -> INTULocationRequestID {
        var location: CLLocation? = nil
        
        if self.location != nil {
            location = CLLocation(latitude: self.location!.latitude,
                                  longitude: self.location!.longitude)
        }
        
        block(location, .block, self.returnStatus)
        return 0
    }
    
    func cancelLocationRequest(_ requestId: INTULocationRequestID) {
        self.cancelLocationCall?()
    }
    
    
}

final class LocationRepositoryTests: QuickSpec {
    override func spec() {
        describe("when dealing with location") {
            it("should parse correctly a success location and cancel request after completed") {
                let locationManager = FauxLocationManager()
                let locationRepository = LocationRepository(locationManager: locationManager)
                let expc = QuickSpec.expectation(description: "success location response")
                let expc2 = QuickSpec.expectation(description: "cancel location request")
                let disposeBag = DisposeBag()
                
                locationManager.cancelLocationCall = {
                    expc2.fulfill()
                }
                
                locationRepository.requestLocation().subscribe { single in
                    switch single {
                    case .success(let location):
                        expect(location.coordinate.longitude).to(beCloseTo(CLLocationCoordinate2D.anyLocation.longitude))
                        expect(location.coordinate.latitude).to(beCloseTo(CLLocationCoordinate2D.anyLocation.latitude))
                        expc.fulfill()
                    case .error:
                        XCTFail()
                    }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should receive error for any status different from success") {
                let allLocationStatus: [INTULocationStatus] = [.error,
                                                               .servicesDenied,
                                                               .servicesDisabled,
                                                               .servicesNotDetermined,
                                                               .servicesRestricted]
                
                for status in allLocationStatus {
                    let locationManager = FauxLocationManager(returnStatus: status)
                    let locationRepository = LocationRepository(locationManager: locationManager)
                    let expc = QuickSpec.expectation(description: "success location response")
                    
                    let disposeBag = DisposeBag()
                    
                    locationRepository.requestLocation().subscribe { single in
                        switch single {
                        case .success:
                            XCTFail("success status for error status: \(status)")
                        case .error(let error):
                            expect(error).to(beAKindOf(LocationError.self))
                            expc.fulfill()
                        }
                        }.disposed(by: disposeBag)
                    
                    QuickSpec.waitForExpectationsDefaultTimeout()
                }
            }
            
            it("should receive error for a nil location") {
                let locationManager = FauxLocationManager(location: nil)
                let locationRepository = LocationRepository(locationManager: locationManager)
                let expc = QuickSpec.expectation(description: "error location response")
                let disposeBag = DisposeBag()
                
                locationRepository.requestLocation().subscribe { single in
                    switch single {
                    case .success:
                        XCTFail()
                    case .error(let error):
                        let err = error as! LocationError
                        expect(err).to(equal(LocationError.unknown))
                        expc.fulfill()
                    }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
    }
}
