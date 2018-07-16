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
        let requestModel = Logout(baseUrl: baseUrl, userID: userID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registration(userData: UserData, completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void) {
        let requestModel = SingIn(baseUrl: baseUrl, userData: userData)
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
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let userID: Int
        var parameters: Parameters? {
            return [
                "id_user": userID
            ]
        }
    }
}

extension Auth {
    struct SingIn: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
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
