/* Фабрика для работы с данными пользователя */

import Foundation
import Alamofire

protocol UserProfileRequestFactory {
    func changeUserData(
        userData: UserData,
        completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void
        )
}
