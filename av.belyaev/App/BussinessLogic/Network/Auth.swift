//
//  Auth.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

class Auth: BaseRequestFactory, AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userID: Int, completionHandler: @escaping (DataResponse<LogoutResult>) -> Void) {
        let requestModel = SingOut(baseUrl: baseUrl, id: userID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registration(userInfo: UserInfo, completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void) {
        let requestModel = ChechIn(baseUrl: baseUrl, userInfo: userInfo)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}


extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        let login: String
        let password: String
        
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}

extension Auth {
    struct SingOut: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let id: Int
        
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
}

extension Auth {
    struct ChechIn: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        let userInfo: UserInfo
        
        var parameters: Parameters? {
            return [
                "id_user": userInfo.id,
                "username": userInfo.userName,
                "password": userInfo.password,
                "email": userInfo.email,
                "gender": userInfo.gender,
                "credit_card": userInfo.creditCard,
                "bio": userInfo.bio
                
            ]
        }
    }
}
