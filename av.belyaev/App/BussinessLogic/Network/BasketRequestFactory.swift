/**
* Фабрика запросов Корзины Пользователя
*/

import Foundation
import Alamofire

protocol BasketRequestFactory {
    
    func addProduct(
        productID: Int,
        quantity: Int,
        completionHandler: @escaping (DataResponse<AddingProductBasketResult>) -> Void
        )

    func deleteProduct(
        productID: Int,
        completionHandler: @escaping (DataResponse<DeleteProductBasketResult>) -> Void
        )
    
    func payOrder(
        paidType: Int,
        shippingAddress: String,
        completionHandler: @escaping (DataResponse<PaidOrderResult>) -> Void
        )
}
