import Foundation

struct ReviewViewModel {
    private let review: Review
    
    var name: String {
        return self.review.authorName
    }
    var rating: String {
        return "Avaliação: \(self.review.rating)"
    }
    var reviewText: String {
        return self.review.text
    }
    
    init(review: Review) {
        self.review = review
    }
}
