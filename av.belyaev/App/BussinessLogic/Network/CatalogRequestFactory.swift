/**
* Фабрика запросов для работы с каталогом
*/

import Foundation
import Alamofire

protocol CatalogRequestFactory {

    func getCatalog(
        pageNumber: Int,
        categoryID: Int,
        completionHandler: @escaping (DataResponse<[ProductSimpleResult]>) -> Void
        )
    
    func getProduct(
        productID: Int,
        completionHandler: @escaping (DataResponse<ProductFullResult>) -> Void
        )
}
