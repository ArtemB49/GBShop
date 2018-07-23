/**
* Модель ответа сервера на Запрос данных о товаре (подробный)
*/

import Foundation

struct ProductFullResult: Codable {
    let result: Int
    let name: String
    let price: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }    
}
