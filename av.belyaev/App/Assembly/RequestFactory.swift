/**
* Фабрика запросов
*/

import Foundation
import Alamofire

class RequestFactory {
    func makeErrorParser() -> AbstractErrorParser {
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
    
    func makeAuthRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Auth(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
    
    
    func makeChangeUserDataRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return UserProfile(
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
    
    func makeReviewsRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Reviews(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
    
    func makeBasketRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Basket(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}
