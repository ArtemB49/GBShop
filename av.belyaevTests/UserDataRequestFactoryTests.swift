//
// Created by Артем Б on 14.07.2018.
// Copyright (c) 2018 Артем Б. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
import OHHTTPStubs
@testable import av_belyaev

class UserDataRequestFactoryTests: XCTestCase {


    var userData: UserDataRequestFactory?

    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        userData = factory.makeModificationRequestFactory()
    }

    override func tearDown() {
        super.tearDown()
        userData = nil
        OHHTTPStubs.removeAllStubs()
    }

    func testChangeProfile() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("changeUserData.json")) { request in

            let fileUrl = Bundle.main.url(forResource: "ChangeUserData", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil)
        }

        var result: ModificationResult?
        let userInfo = UserInfo(
                id: 322,
                userName: "ivan",
                password: "good",
                email: "bbo@bob.ru",
                gender: "m",
                creditCard: "3222_8777_9999_7777",
                bio: "Hello, I am Ivan"
        )
        userData?.editUserData(userInfo: userInfo){ response in
            
            result = response.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(result)
    }
}
