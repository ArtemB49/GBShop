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


    var userProfile: UserProfileRequestFactory?

    override func setUp() {
        super.setUp()
        let factory = RequestFactoryMock()
        userProfile = factory.makeChangeUserDataRequestFactory()
    }

    override func tearDown() {
        super.tearDown()
        userProfile = nil
        OHHTTPStubs.removeAllStubs()
    }

    func testChangeProfile() {
        let exp = expectation(description: "")

        stub(condition: isMethodGET() && pathEndsWith("changeUserData.json")) { _ in

            let fileUrl = Bundle.main.url(forResource: "ChangeUserData", withExtension: "json")!

            return OHHTTPStubsResponse(
                    fileURL: fileUrl,
                    statusCode: 200,
                    headers: nil)
        }

        var result: ChangeUserDataResult?
        let userData = UserData(
                id: 322,
                userName: "ivan",
                password: "good",
                email: "bbo@bob.ru",
                gender: "m",
                creditCard: "3222_8777_9999_7777",
                bio: "Hello, I am Ivan"
        )
        userProfile?.changeUserData(userData: userData) { response in
            
            result = response.value
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(result)
    }
}
