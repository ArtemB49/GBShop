/**
* Реализаци фабрики работы с каталогом
*/

import Foundation
import Alamofire

class Catalog: BaseRequestFactory, CatalogRequestFactory {
    func getCatalog(
        pageNumber: Int,
        categoryID: Int,
        completionHandler: @escaping (DataResponse<[ProductSimpleResult]>) -> Void
    ) {
        let requestModel = CatalogAll(
                baseUrl: baseUrl,
                pageNumber: pageNumber,
                categoryID: categoryID
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProduct(
            productID: Int,
            completionHandler: @escaping (DataResponse<ProductFullResult>) -> Void
    ) {
        let requestModel = Product(baseUrl: baseUrl, productID: productID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Catalog {
    struct CatalogAll: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        let pageNumber: Int
        let categoryID: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryID
            ]
        }
    }
}

extension Catalog {
    struct Product: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        let productID: Int
        var parameters: Parameters? {
            return [
                "id_product": productID
            ]
        }
    }
}
