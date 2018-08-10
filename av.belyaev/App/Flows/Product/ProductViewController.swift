/**
 * Контроллер товара
 */

import UIKit

class ProductViewController: UIViewController, TrackableMixin {
    
    let catalogRequestFactory: CatalogRequestFactory
        = RequestFactory().makeCatalogRequestFactory()
    let reviewRequestFactory: ReviewRequestFactory
        = RequestFactory().makeReviewsRequestFactory()
    let basket = BasketLogic.sharedInstance

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    
    @IBAction func addToBasketButtonDidTap(_ sender: UIButton) {
        if let product = self.product {
            basket.products.append(product)
            track(AnalyticsEvent.addToBasket(nameProduct: product.name))
            increaseNumberBasketItem()
        }
    }
    
    func increaseNumberBasketItem() {
        if let tabController = self.tabBarController,
            let tabItems = tabController.tabBar.items {
            tabItems[1].badgeValue = String(basket.products.count)
            tabItems[1].isEnabled = true
        }
    }
    
    var product: ProductFullResult?
    
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
                self.product = product
                DispatchQueue.main.async {
                    self.nameLabel.text = product.name
                    self.priceProduct.text = String(product.price)
                    self.descriptionLabel.text = product.description
                }
                self.track(AnalyticsEvent.showProduct(nameProduct: product.name))
                
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
                DispatchQueue.main.async {
                    self.reviewTitleLabel.text
                        = ProductVCConstants.titleReviewLabel.rawValue
                }
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
