import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class ResultListTests: QuickSpec {
    override func spec() {
        describe("When dealing with ResultList deserealization") {
            it("should parse response correctly") {
                let resultList = ResultList.stubbed(from: "nearby")
                expect(resultList.results.count).to(equal(20))
            }
        }
    }
}
