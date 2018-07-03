import Quick
import Nimble
@testable import Youse_Challenge

final class ReviewViewModelTests: QuickSpec {
    override func spec() {
        it("should parse correctly from entity") {
            let review = Review.stubbed(from: "review")
            let viewModel = ReviewViewModel(review: review)
            
            expect(viewModel.name).to(equal("JBR GB"))
            expect(viewModel.reviewText).to(equal("Péssimo atendimento no telefone que aparece no maps, a já me atendeu dando coise dizendo que esse telefone não vende  etc, por mais que não seja lugar de vendas , acho que se atende um telefone assim ..."))
            expect(viewModel.rating).to(equal("Avaliação: 1.0"))
        }
    }
}
