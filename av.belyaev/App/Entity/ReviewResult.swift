/* Модель Отзывов */

import Foundation

struct ReviewResult: Codable {
    let result: Int
    let reviews: [Review]
}

struct Review: Codable {
    let reviewID: Int
    let productID: Int
    let ownerName: String
    let description: String
    let stars: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case reviewID = "id_review"
        case productID = "id_product"
        case ownerName = "owner_name"
        case description = "description"
        case stars = "stars"
        case date = "date"
    }
}
