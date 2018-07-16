/* Модель ответа сервера на Добавление отзыва */

import Foundation

struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String
}
