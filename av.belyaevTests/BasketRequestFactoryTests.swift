/**
 * Тестирование запросов корзины используя OHHTTPStubs
 */

import Foundation
import XCTest
import Alamofire
import OHHTTPStubs
@testable import av_belyaev

class BasketRequestFactoryTests: XCTestCase {
    
    
    var basketRequestFactory: BasketRequestFactory?
    
    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        basketRequestFactory = factory.makeBasketRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        basketRequestFactory = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddProduct() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("addToBasket.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "DeleteFromBasket", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil
            )
        }


        var addProductResult: AddingProductBasketResult?

        basketRequestFactory?.addProduct(
                productID: 1,
                quantity: 1
        ) { request in
            addProductResult = request.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(addProductResult)
    }

    func testDeleteProductFromBasket() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("deleteFromBasket.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "DeleteFromBasket", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil
            )
        }


        var deleteProductBasketResult: DeleteProductBasketResult?

        basketRequestFactory?.deleteProduct(
                productID: 1
        ) { request in
            deleteProductBasketResult = request.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(deleteProductBasketResult)
    }
}
