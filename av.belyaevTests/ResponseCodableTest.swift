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
    let userId: Int
    let id: Int
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
        
        var post: PostStub?
        
        Alamofire
            .request("https://jsonplaceholder.typicode.com/posts/1")
            .respondeCodable(errorParser: errorParser){ (response: DataResponse<PostStub>) in
                
                post = response.value
                exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(post)
    }
}
