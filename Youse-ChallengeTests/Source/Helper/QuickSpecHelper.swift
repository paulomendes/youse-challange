import Quick

extension QuickSpec {
    static func waitForExpectationsDefaultTimeout(timeout: Double = 1.0) {
        self.current.waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    static func expectation(description: String) -> XCTestExpectation {
        return self.current.expectation(description: description)
    }
}
