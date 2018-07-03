import Quick
import Nimble
import CoreLocation
@testable import Youse_Challenge

final class ReviewTests: QuickSpec {
    override func spec() {
        describe("When dealing with Review deserealization") {
            it("should parse json correctly") {
                let review = Review.stubbed(from: "review")
                expect(review.authorName).to(equal("JBR GB"))
                expect(review.rating).to(equal(1))
                expect(review.relativeTimeDescription).to(equal("5 meses atrás"))
                expect(review.text).to(equal("Péssimo atendimento no telefone que aparece no maps, a já me atendeu dando coise dizendo que esse telefone não vende  etc, por mais que não seja lugar de vendas , acho que se atende um telefone assim ..."))
            }
        }
    }
}
