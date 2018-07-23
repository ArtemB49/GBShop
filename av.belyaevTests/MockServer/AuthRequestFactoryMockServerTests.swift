/**
 * Тестирование запросов авторизации используя мок сервер
 */

import Foundation
import XCTest
import Alamofire
@testable import av_belyaev

class AuthRequestFactoryMockServerTests: XCTestCase {
    
    
    var auth: AuthRequestFactory?
    var errorParser: ErrorParserStubs!
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        auth = factory.makeAuthRequestFactory()
        errorParser = ErrorParserStubs()
    }
    
    override func tearDown() {
        super.tearDown()
        auth = nil
        errorParser = nil
    }
    
    func testAuth() {
        let exp = expectation(description: "")
        var loginResult: LoginResult?
        
        let parameters: [String: Any] = [
            "username": "bob",
            "password": "bob"
        ]
        
        Alamofire.request(
            "http://localhost:8181/login",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
            )
            .responseCodable(errorParser: errorParser) {(response: DataResponse<LoginResult>) in
                
                loginResult = response.value
                exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(loginResult)
    }
    
    func testLogout() {
        let exp = expectation(description: "")
        var logoutResult: LogoutResult?
        let parameters: [String: Any] = [
            "id_user": 1
        ]

        Alamofire.request(
            "http://localhost:8181/logout",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
            )
            .responseCodable(errorParser: errorParser) {(response: DataResponse<LogoutResult>) in

                logoutResult = response.value
                exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(logoutResult)
    }
    
    func testRegister() {
        let exp = expectation(description: "")
        var registerResult: RegistrationResult?
        let parameters: [String: Any] = [
            "id_user": 1,
            "username": "bob",
            "password": "boec",
            "email": "bbo@bob.ru",
            "gender": "m",
            "creditCard": "3222_8777_9999_7777",
            "bio": "Hello, I am Bob"
        ]

        Alamofire.request(
                        "http://localhost:8181/register",
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default
                )
                .responseCodable(errorParser: errorParser) {(response: DataResponse<RegistrationResult>) in

                    registerResult = response.value
                    exp.fulfill()
                }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(registerResult)
    }
    
    
}
