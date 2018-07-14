//
//  RequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbsrtactErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory<T>() -> T!{
        let errorParser = makeErrorParser()
        return Auth(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
    
    
    func makeModificationRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return UserData(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
    

}
