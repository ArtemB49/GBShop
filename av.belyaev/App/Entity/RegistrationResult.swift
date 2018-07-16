/* Модель ответа сервера на регистрацию */

import Foundation

struct RegistrationResult: Codable {
    let result: Int
    let userMessage: String
}
