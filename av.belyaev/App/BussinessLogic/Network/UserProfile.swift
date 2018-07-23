/**
*   Реализация фабрики пользователя
*/

import Foundation
import Alamofire

class UserProfile: BaseRequestFactory, UserProfileRequestFactory {
    func changeUserData(userData: UserData, completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserProfile(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension UserProfile {
    struct ChangeUserProfile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        let userData: UserData
        
        var parameters: Parameters? {
            return [
                "id_user": userData.userID,
                "username": userData.userName,
                "password": userData.password,
                "email": userData.email,
                "gender": userData.gender,
                "credit_card": userData.creditCard,
                "bio": userData.bio
                
            ]
        }
    }
}
