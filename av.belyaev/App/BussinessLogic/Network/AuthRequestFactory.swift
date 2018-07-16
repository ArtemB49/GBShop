//
//  AuthRequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

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
