/* Модель пользователя */

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
}

struct User: Codable {
    let userID: Int
    let login: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id_user"
        case login = "user_login"
        case firstName = "user_name"
        case lastName = "user_lastname"
    }
}
