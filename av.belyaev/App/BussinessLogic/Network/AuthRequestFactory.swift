/**
* Фабрика авторизации
*/

import Foundation
import Alamofire

protocol AuthRequestFactory {
    
    func login(
        userName: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>) -> Void
        )
    
    func logout(
        userID: Int,
        completionHandler: @escaping (DataResponse<LogoutResult>) -> Void
        )
    
    func registration(
        userData: UserData,
        completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void
        )
}
