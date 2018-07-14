//
//  UserDataRequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 09.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

protocol UserDataRequestFactory {
    func editUserData(
        userInfo: UserInfo,
        completionHandler: @escaping (DataResponse<ModificationResult>) -> Void )
}
