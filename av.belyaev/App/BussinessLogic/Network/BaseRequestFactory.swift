//
//  BaseRequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequestFactory: AbstractRequestFactory {
    
    let errorParser: AbsrtactErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string:
        "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbsrtactErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}
