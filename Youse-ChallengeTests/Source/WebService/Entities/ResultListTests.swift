import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class ResultListTests: QuickSpec {
    override func spec() {
        describe("When dealing with ResultList deserealization") {
            it("should parse response correctly for a not empyt json") {
                let resultList = ResultList.stubbed(from: "nearby")
                expect(resultList.results.count).to(equal(20))
            }
            
            it("should parse response correctly for a empyt json") {
                let resultList = ResultList.stubbed(from: "nearby-empty")
                expect(resultList.results.count).to(equal(0))
            }
        }
    }
}
