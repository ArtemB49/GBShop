/**
* Модель ответа сервера на Регистрацию пользователя
*/

import Foundation

struct RegistrationResult: Codable {
    let result: Int
    let userMessage: String
}
