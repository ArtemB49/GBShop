/**
* Модель ответа сервера на Запрос данных списка товаров (Краткий)
*/

import Foundation


struct ProductSimpleResult: Codable {
    let productID: Int
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case productID = "id_product"
        case name = "product_name"
        case price = "price"
    }
}
