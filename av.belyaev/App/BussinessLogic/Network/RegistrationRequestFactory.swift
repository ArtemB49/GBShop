//
//  RegistrationRequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 09.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

protocol RegistrationRequestFactory {
    func registration(
        userName: String,
        password: String,
        email: String,
        gender: String,
        creditCard: String,
        bio: String,
        completionHandler: @escaping (DataResponse<RegistrationResult>) -> Void )
}
