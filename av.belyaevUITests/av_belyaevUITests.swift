//
//  av_belyaevUITests.swift
//  av.belyaevUITests
//
//  Created by Артем Б on 03.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import XCTest
// swiftlint:disable type_name
class av_belyaevUITests: XCTestCase {
// swiftlint:enable force_cast
    
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        scrollViewsQuery = app.scrollViews
        setupSnapshot(app)

        /* In UI tests it’s important to set the initial state
            - such as interface orientation - required for your tests
            before they run. The setUp method is a good place to do this.
         */
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        app.tabBars.buttons["Пользователь"].tap()

        app.buttons["registeringButton"].tap()

        registration(
            name: "testName",
            email: "test@email.ru",
            card: "3222-3333-3333-2222",
            about: "Let me speak from my heath",
            password: "testpassword"
        )
        
        app.buttons["logoutButton"].tap()
        
        auth(login: "test", password: "test")
    }
    
    func registration(
        name: String,
        email: String,
        card: String,
        about: String,
        password: String
        ) {
        
        let nameField = app.textFields["nameField"]
        nameField.tap()
        nameField.typeText(name)
        
        let emailField = app.textFields["emailField"]
        emailField.tap()
        emailField.typeText(email)
        
        let cardField = app.textFields["cardField"]
        cardField.tap()
        cardField.typeText(card)
        
        let aboutField = app.textViews["aboutField"]
        aboutField.tap()
        aboutField.typeText(about)
        
        let passwordField = app.textFields["passwordField"]
        passwordField.tap()
        passwordField.typeText(password)
        
        let confirmPasswordField = app.textFields["confirmPasswordField"]
        confirmPasswordField.tap()
        confirmPasswordField.typeText(password)
        
        snapshot()
        
        let buttonEnter = scrollViewsQuery.buttons["registerButton"]
        buttonEnter.tap()
        
    }
    
    func auth(login: String, password: String) {
        let loginField = app.textFields["login"]
        loginField.tap()
        loginField.typeText(login)
        
        let passwordField = app.secureTextFields["password"]
        passwordField.tap()
        passwordField.typeText(password)
        
        let buttonEnter = scrollViewsQuery.buttons["go"]
        buttonEnter.tap()
    }
    
}
