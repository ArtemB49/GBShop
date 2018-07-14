//
//  AuthRequestFactorytests.swift
//  av.belyaevTests
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
import OHHTTPStubs
@testable import av_belyaev

class AuthRequestFactoryTests: XCTestCase {
    
    var auth: AuthRequestFactory?
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        auth = factory.makeAuthRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        auth = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAuth() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("login.json")) { request in
            
            let fileUrl = Bundle.main.url(forResource: "Login", withExtension: "json")!
            
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil)
        }
        
        var user: LoginResult?
        auth?.login(
            userName: "bob",
            password: "123"
        ){ result in
            user = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(user)
    }
    
    func testLogout() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("logout.json")) { request in
            
            let fileUrl = Bundle.main.url(forResource: "Logout", withExtension: "json")!
            
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil)
        }
        
        var logoutResult: LogoutResult?
        auth?.logout(userID: 1){ result in
            logoutResult = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(logoutResult)
    }
    
    func testRegister() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("registerUser.json")) { request in
            
            let fileUrl = Bundle.main.url(forResource: "Register", withExtension: "json")!
            
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil)
        }
        
        var result: RegistrationResult?
        let userInfo = UserInfo(
            id: 322,
            userName: "bob",
            password: "boec",
            email: "bbo@bob.ru",
            gender: "m",
            creditCard: "3222_8777_9999_7777",
            bio: "Hello, I am Bob"
        )
        auth?.registration(userInfo: userInfo){ request in
            result = request.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(result)
    }
    

}
