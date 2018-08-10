/**
* Основа для фабрик запросов
*/

import Foundation
import Alamofire

class Reviews: BaseRequestFactory, ReviewRequestFactory {
    func deleteReview(reviewID: Int, completionHandler: @escaping (DataResponse<DeleteReviewResult>) -> Void) {
        let requestModel = DeleteReview(baseUrl: baseUrl, reviewID: reviewID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(
        userID: Int,
        textReview: String,
        completionHandler: @escaping (DataResponse<AddingReviewResult>) -> Void ) {
        let requestModel = AddReview(baseUrl: baseUrl, userID: userID, textReview: textReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func listReview(
        pageNumber: Int,
        productID: Int,
        completionHandler: @escaping (DataResponse<ReviewResult>) -> Void) {
        let mockServerUrl = URL(string: "http://0.0.0.0:8181/")!
        let requestModel = ListReview(baseUrl: mockServerUrl, pageNumber: 1, productID: 1)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Reviews {
    struct ListReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/getReviewsById"
        let pageNumber: Int
        let productID: Int
        let encoding: RequestRouterEncoding = .json
        
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_product": productID
            ]
        }
    }
}

extension Reviews {
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/addReview.json"
        let userID: Int
        let textReview: String
        
        var parameters: Parameters? {
            return [
                "id_user": userID,
                "text": textReview
            ]
        }
    }
}

extension Reviews {
    struct DeleteReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/removeReview.json"
        let reviewID: Int
        
        var parameters: Parameters? {
            return [
                "id_comment": reviewID
            ]
        }
    }
}
