/**
 * Тестирование запросов отзывов используя OHHTTPStubs
 */

import Foundation
import XCTest
import Alamofire
import OHHTTPStubs
@testable import av_belyaev

class ReviewReguestFactoryTests: XCTestCase {
    
    
    var review: ReviewRequestFactory?
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        review = factory.makeReviewsRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        review = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddReview() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("addReview.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "AddReview", withExtension: "json")!

            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil)
        }

        var addReviewResult: AddingReviewResult?

        review?.addReview(
                userID: 1,
                textReview: "Norm") { request in
            addReviewResult = request.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(addReviewResult)
    }

    func testDeleteReview() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("removeReview.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "DeleteReview", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil)
        }

        var deleteReviewResult: DeleteReviewResult?

        review?.deleteReview(reviewID: 1) { request in
            deleteReviewResult = request.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(deleteReviewResult)
    }
}
