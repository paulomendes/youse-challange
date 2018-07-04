import Quick
import Nimble
import Moya
import CoreLocation
@testable import Youse_Challenge

final class FauxRequestProvider: RequestProviderType {
    private var resultList: Bool
    private var placeDetail: Bool
    private var error: Bool
    
    init(resultList: Bool = false, placeDetail: Bool = false, error: Bool = false) {
        self.resultList = resultList
        self.placeDetail = placeDetail
        self.error = error
    }
    
    var didRequest: ((_ target: Moya.TargetType)->Void)?
    
    func request<Model: Decodable>(target: Moya.TargetType, completion: @escaping (_ result: Result<Model>) -> Void ) {
        self.didRequest?(target)
        
        if self.resultList {
            let result = ResultList.stubbed(from: "nearby")
            completion(.success(result as! Model))
        }
        
        if self.placeDetail {
            let result = PlaceDetails.stubbed(from: "place-details")
            completion(.success(result as! Model))
        }
        
        if self.error {
            completion(.failure(YCError.serializationError))
        }
    }
}

final class GooglePlaceRepositoryTests: QuickSpec {
    override func spec() {
        describe("When requesting Car Repair List") {
            it("should request with correct target") {
                let fauxRequestProvider = FauxRequestProvider()
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                let expc = QuickSpec.expectation(description: "called getCarRepairList")
                let anyLocation = CLLocationCoordinate2D.anyLocation
                let params = CarRepairParameters(location: anyLocation)
                
                fauxRequestProvider.didRequest = { target in
                    expect(target.baseURL.absoluteString).to(equal("https://maps.googleapis.com/maps/api/"))
                    expect(target.path).to(equal("place/nearbysearch/json"))
                    expc.fulfill()
                }
                
                repository.getCarRepairList(with: params, completion: { (result) in
                    switch result {
                    case .success:
                        XCTFail()
                    case .failure:
                        XCTFail()
                    }
                })

                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return success for a success response") {
                let fauxRequestProvider = FauxRequestProvider(resultList: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                
                let anyLocation = CLLocationCoordinate2D.anyLocation
                let params = CarRepairParameters(location: anyLocation)
                let expc = QuickSpec.expectation(description: "success call for repair list")
                
                repository.getCarRepairList(with: params, completion: { (result) in
                    switch result {
                    case .success(let places):
                        expect(places).to(beAKindOf(ResultList.self))
                        expc.fulfill()
                    case .failure:
                        XCTFail()
                    }
                })
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return error for an error response") {
                let fauxRequestProvider = FauxRequestProvider(error: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                
                let anyLocation = CLLocationCoordinate2D.anyLocation
                let params = CarRepairParameters(location: anyLocation)
                let expc = QuickSpec.expectation(description: "error call for repair list")
                
                repository.getCarRepairList(with: params, completion: { (result) in
                    switch result {
                    case .success:
                        XCTFail()
                    case .failure(let error):
                        expect(error).to(beAKindOf(YCError.self))
                        let err = error as! YCError
                        expect(err).to(equal(YCError.serializationError))
                        expc.fulfill()
                    }
                })

                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
        
        describe("When requesting Car Detail List") {
            it("should request with correct target") {
                let fauxRequestProvider = FauxRequestProvider()
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                let expc = QuickSpec.expectation(description: "called getCarRepairList")
                let params = PlaceDetailsParameters(placeId: "placeid")
                
                fauxRequestProvider.didRequest = { target in
                    expect(target.baseURL.absoluteString).to(equal("https://maps.googleapis.com/maps/api/"))
                    expect(target.path).to(equal("place/details/json"))
                    expc.fulfill()
                }
                
                repository.getCarRepairDetails(with: params, completion: { (result) in
                    switch result {
                    case .success:
                        XCTFail()
                    case .failure:
                        XCTFail()
                    }
                })
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return success for a success response") {
                let fauxRequestProvider = FauxRequestProvider(placeDetail: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)

                let params = PlaceDetailsParameters(placeId: "placeid")
                let expc = QuickSpec.expectation(description: "success call for detail")
                
                repository.getCarRepairDetails(with: params, completion: { (result) in
                    switch result {
                    case .success(let places):
                        expect(places).to(beAKindOf(PlaceDetails.self))
                        expc.fulfill()
                    case .failure:
                        XCTFail()
                    }
                })
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return error for an error response") {
                let fauxRequestProvider = FauxRequestProvider(error: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                
                let params = PlaceDetailsParameters(placeId: "placeid")
                let expc = QuickSpec.expectation(description: "error call for detail")
                
                repository.getCarRepairDetails(with: params, completion: { (result) in
                    switch result {
                    case .success:
                        XCTFail()
                    case .failure(let error):
                        expect(error).to(beAKindOf(YCError.self))
                        let err = error as! YCError
                        expect(err).to(equal(YCError.serializationError))
                        expc.fulfill()
                    }
                })

                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
    }
}
