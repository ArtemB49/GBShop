/**
* Модель ответа сервера на Добавление отзыва
*/

import Foundation

struct AddingReviewResult: Codable {
    let result: Int
    let userMessage: String
}
