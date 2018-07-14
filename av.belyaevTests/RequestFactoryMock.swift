//
//  RequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire
import OHHTTPStubs
@testable import av_belyaev

class RequestFactoryMock {
    
    func makeErrorParser() -> AbsrtactErrorParser {
        return ErrorParserStubs()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        OHHTTPStubs.isEnabled(for: configuration)
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
    
    func makeCatalogRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Catalog(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
    

}
