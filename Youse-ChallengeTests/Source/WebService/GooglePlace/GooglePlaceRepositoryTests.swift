import Quick
import Nimble
import RxSwift
import Moya
import CoreLocation
@testable import Youse_Challenge

final class FauxRequestProvider: RequestProviderType {
    private var resultList: Bool
    private var placeDetail: Bool
    
    init(resultList: Bool = false, placeDetail: Bool = false) {
        self.resultList = resultList
        self.placeDetail = placeDetail
    }
    
    var didRequest: ((_ target: Moya.TargetType)->Void)?
    
    func request<Model: Decodable>(target: Moya.TargetType) -> Single<Model> {
        self.didRequest?(target)
        
        if self.resultList {
            let result = ResultList.stubbed(from: "nearby")
            return Single.just(result) as! PrimitiveSequence<SingleTrait, Model>
        }
        
        if self.placeDetail {
            let result = PlaceDetails.stubbed(from: "place-details")
            return Single.just(result) as! PrimitiveSequence<SingleTrait, Model>
        }
        
        return Single.never()
    }
}

final class GooglePlaceRepositoryTests: QuickSpec {
    override func spec() {
        describe("When requestin Car Repair List") {
            it("should request with correct target") {
                let disposeBag = DisposeBag()
                
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
                
                repository
                    .getCarRepairList(with: params)
                    .subscribe{ single in
                        switch single {
                        case .success:
                            XCTFail()
                        case .error:
                            XCTFail()
                        }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return success for a success response") {
                let disposeBag = DisposeBag()
                let fauxRequestProvider = FauxRequestProvider(resultList: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                
                let anyLocation = CLLocationCoordinate2D.anyLocation
                let params = CarRepairParameters(location: anyLocation)
                let expc = QuickSpec.expectation(description: "success call for repair list")
                
                repository
                    .getCarRepairList(with: params)
                    .subscribe{ single in
                        switch single {
                        case .success(let places):
                            expect(places).to(beAKindOf(ResultList.self))
                            expc.fulfill()
                        case .error:
                            XCTFail()
                        }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
        
        describe("When requestin Car Detail List") {
            it("should request with correct target") {
                let disposeBag = DisposeBag()
                
                let fauxRequestProvider = FauxRequestProvider()
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)
                let expc = QuickSpec.expectation(description: "called getCarRepairList")
                let params = PlaceDetailsParameters(placeId: "placeid")
                
                fauxRequestProvider.didRequest = { target in
                    expect(target.baseURL.absoluteString).to(equal("https://maps.googleapis.com/maps/api/"))
                    expect(target.path).to(equal("place/details/json"))
                    expc.fulfill()
                }
                
                repository
                    .getCarRepairDetails(with: params)
                    .subscribe{ single in
                        switch single {
                        case .success:
                            XCTFail()
                        case .error:
                            XCTFail()
                        }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
            
            it("should request return success for a success response") {
                let disposeBag = DisposeBag()
                let fauxRequestProvider = FauxRequestProvider(placeDetail: true)
                let repository = GooglePlacesRepository(requestProvider: fauxRequestProvider)

                let params = PlaceDetailsParameters(placeId: "placeid")
                let expc = QuickSpec.expectation(description: "success call for repair list")
                
                repository
                    .getCarRepairDetails(with: params)
                    .subscribe{ single in
                        switch single {
                        case .success(let places):
                            expect(places).to(beAKindOf(PlaceDetails.self))
                            expc.fulfill()
                        case .error:
                            XCTFail()
                        }
                    }.disposed(by: disposeBag)
                
                QuickSpec.waitForExpectationsDefaultTimeout()
            }
        }
    }
}
