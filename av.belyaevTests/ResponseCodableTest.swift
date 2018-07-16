//
//  ResponseCodableTest.swift
//  av.belyaevTests
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
@testable import av_belyaev

struct PostStub: Codable {
    let userID: Int
    let postID: Int
    let title: String
    let body: String
}

class ResponseCodableTest: XCTestCase {
    
    var errorParser: ErrorParserStubs!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStubs()
        
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        
        let exp = expectation(description: "")
        
        var post: RegistrationResult?
        
        let parameters: [String: Any] = [
            "id_user": 1,
            "username": "bob",
            "password": "bob"
        ]
        
        Alamofire.request(
            "http://localhost:8181/register",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
            )
            .respondeCodable(errorParser: errorParser) {(response: DataResponse<RegistrationResult>) in
                
                post = response.value
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(post)
    }
}
