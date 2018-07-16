//
//  CatalogReguestFactoryTests.swift
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

class CatalogReguestFactoryTests: XCTestCase {


    var catalog: CatalogRequestFactory?

    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        catalog = factory.makeCatalogRequestFactory()
    }

    override func tearDown() {
        super.tearDown()
        catalog = nil
        OHHTTPStubs.removeAllStubs()
    }

    func testCatalogAll() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("catalogData.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "Catalog", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil)
        }

        var result: [ProductSimpleResult]?

        catalog?.getCatalog(pageNumber: 1, categoryID: 1) { request in
            result = request.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(result)
    }
    
    func testProduct() {
        let exp = expectation(description: "")
        
        stub(condition: isMethodGET() && pathEndsWith("getGoodById.json")) { _ in
            
            let fileUrl = Bundle.main.url(forResource: "Product", withExtension: "json")!
            
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil)
        }
        
        var result: ProductFullResult?
        
        catalog?.getProduct(id: 1) { request in
            result = request.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(result)
    }
    
}
