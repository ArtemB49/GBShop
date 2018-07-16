//
// Created by Артем Б on 15.07.2018.
// Copyright (c) 2018 Артем Б. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
@testable import av_belyaev

class CatalogRequestFactoryMockServerTests: XCTestCase {

    var catalog: CatalogRequestFactory?
    var errorParser: ErrorParserStubs!

    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        catalog = factory.makeChangeUserDataRequestFactory()
        errorParser = ErrorParserStubs()
    }

    override func tearDown() {
        super.tearDown()
        catalog = nil
        errorParser = nil
    }

    func testCatalogAll() {
        let exp = expectation(description: "")

        var listProductResult: [ProductSimpleResult]?

        let parameters: [String: Any] = [
            "page_number": 1,
            "id_category": 2
        ]

        Alamofire.request(
                        "http://localhost:8181/catalogData",
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default
                )
                .respondeCodable(errorParser: errorParser) {(response: DataResponse<[ProductSimpleResult]>) in

                    listProductResult = response.value
                    exp.fulfill()
                }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(listProductResult)
    }

    func testProduct() {
        let exp = expectation(description: "")

        var productResult: ProductFullResult?

        let parameters: [String: Any] = [
            "id_product": 1
        ]

        Alamofire.request(
                        "http://localhost:8181/getGoodById",
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default
                )
                .respondeCodable(errorParser: errorParser) {(response: DataResponse<ProductFullResult>) in

                    productResult = response.value
                    exp.fulfill()
                }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(productResult)
    }

}
