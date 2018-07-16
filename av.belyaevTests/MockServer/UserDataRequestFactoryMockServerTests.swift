//
// Created by Артем Б on 15.07.2018.
// Copyright (c) 2018 Артем Б. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
@testable import av_belyaev

class UserDataRequestFactoryMockServerTests: XCTestCase {

    var userProfile: UserProfileRequestFactory?
    var errorParser: ErrorParserStubs!

    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        userProfile = factory.makeChangeUserDataRequestFactory()
        errorParser = ErrorParserStubs()
    }

    override func tearDown() {
        super.tearDown()
        userProfile = nil
        errorParser = nil
    }

    func testChangeUserData() {
        let exp = expectation(description: "")
        var changeUserDataResult: ChangeUserDataResult?
        let parameters: [String: Any] = [
            "id_user": 1,
            "userName": "bob",
            "password": "boec",
            "email": "bbo@bob.ru",
            "gender": "m",
            "creditCard": "3222_8777_9999_7777",
            "bio": "Hello, I am Bob"
        ]

        Alamofire.request(
                        "http://localhost:8181/chandeUserData",
                        method: .post,
                        parameters: parameters,
                        encoding: JSONEncoding.default
                )
                .respondeCodable(errorParser: errorParser) {(response: DataResponse<ChangeUserDataResult>) in

                    changeUserDataResult = response.value
                    exp.fulfill()
                }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(changeUserDataResult)
    }
}
