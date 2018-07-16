/*
 
 */
import Foundation
import Alamofire

protocol ReviewRequestFactory {
    
    func listReview(
        pageNumber: Int,
        productID: Int,
        completionHandler: @escaping (DataResponse<ReviewResult>) -> Void
        )
    
    func addReview(
        userID: Int,
        textReview: String,
        completionHandler: @escaping (DataResponse<AddReviewResult>) -> Void
        )
    
    func deleteReview(
        reviewID: Int,
        completionHandler: @escaping (DataResponse<DeleteReviewResult>) -> Void
    )
}
