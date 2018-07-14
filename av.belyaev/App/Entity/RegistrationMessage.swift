//
//  RegistrationMessage.swift
//  av.belyaev
//
//  Created by Артем Б on 09.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation

struct RegistrationResult: Codable {
    let result: Int
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case userMessage = "userMessage"
    }
}
