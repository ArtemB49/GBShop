//
//  UserData.swift
//  av.belyaev
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

class UserData: BaseRequestFactory, UserDataRequestFactory{
    
    func editUserData(userInfo: UserInfo, completionHandler: @escaping (DataResponse<ModificationResult>) -> Void) {
        let requestModel = Modify(baseUrl: baseUrl, userInfo: userInfo)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension UserData {
    struct Modify: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
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
