/**
* Реализация фабрики запросов Корзины
*/

import Foundation
import Alamofire

class Basket: BaseRequestFactory, BasketRequestFactory {
    
    func payOrder(
        paidType: Int,
        shippingAddress: String,
        completionHandler: @escaping (DataResponse<PaidOrderResult>) -> Void
        ) {
        let requestModel = PaidOrder(
            baseUrl: baseUrl,
            paidType: paidType,
            shippengAddress: shippingAddress
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addProduct(
        productID: Int,
        quantity: Int,
        completionHandler: @escaping (DataResponse<AddingProductBasketResult>) -> Void
        ) {
        let requestModel = AddProduct(
            baseUrl: baseUrl,
            productID: productID,
            quantity: quantity
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteProduct(
            productID: Int,
            completionHandler: @escaping (DataResponse<DeleteProductBasketResult>) -> Void
    ) {
        let requestModel = DeleteProduct(baseUrl: baseUrl, productID: productID )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct AddProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/addToBasket.json"
        let productID: Int
        let quantity: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productID,
                "quantity": quantity
            ]
        }
    }
}

extension Basket {
    struct DeleteProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/deleteFromBasket.json"
        let productID: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productID
            ]
        }
    }
}

extension Basket {
    struct PaidOrder: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "/paidOrder"
        let paidType: Int
        let shippengAddress: String
        
        var parameters: Parameters? {
            return [
                "paid_type": paidType,
                "shipping_address": shippengAddress
            ]
        }
    }
}
