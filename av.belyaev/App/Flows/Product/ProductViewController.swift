/**
 * Контроллер товара
 */

import UIKit

class ProductViewController: UIViewController {
    
    let catalogRequestFactory: CatalogRequestFactory
        = RequestFactory().makeCatalogRequestFactory()
    let reviewRequestFactory: ReviewRequestFactory
        = RequestFactory().makeReviewsRequestFactory()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    
    var productID: Int? {
        didSet {
            guard let productID = productID else {
                return
            }
            getProduct(with: productID)
            getReviews(pageNumber: 1, productID: productID)
        }
    }
    
    func getProduct(with productID: Int) {
        catalogRequestFactory.getProduct(productID: productID) { response in
            switch response.result {
            case .success(let product):
                DispatchQueue.main.async {
                    self.nameLabel.text = product.name
                    self.priceProduct.text = String(product.price)
                    self.descriptionLabel.text = product.description
                }
                print(product)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getReviews(pageNumber: Int, productID: Int) {
        reviewRequestFactory.listReview(
            pageNumber: pageNumber,
            productID: productID
        ) { response in
            switch response.result {
            case .success(let reviewResult):
                if reviewResult.result == 1 {
                    self.createReviewView(
                        reviews: reviewResult.reviews
                    )
                }
            case .failure(let error):
                self.reviewTitleLabel.text = "Нет отзывов"
                print("Отзывы работают только с использованием мок сервера")
                print(error.localizedDescription)
            }
        }
    }
    
    func createReviewView(reviews: [Review]) {
        reviews.forEach { (review) in
            DispatchQueue.main.async {
                let reviewStackViewWidth = self.reviewStackView.frame.width
                let reviewView = ReviewCompositeView()
                reviewView.date = review.date
                reviewView.ownerName = review.ownerName
                reviewView.text = review.description
                reviewView.countStars = review.stars
                reviewView
                    .widthAnchor
                    .constraint(equalToConstant: reviewStackViewWidth)
                    .isActive = true
                reviewView
                    .heightAnchor
                    .constraint(equalToConstant: 200)
                    .isActive = true
                self.reviewStackView.translatesAutoresizingMaskIntoConstraints = false
                self.reviewStackView.addArrangedSubview(reviewView)
            }
        }
    }
}
