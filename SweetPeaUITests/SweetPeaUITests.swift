//
//  SweetPeaUITests.swift
//  SweetPeaUITests
//
//  Created by Ben Murphy on 1/9/17.
//  Copyright © 2017 Constellation Software. All rights reserved.
//

import XCTest

class SweetPeaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()

        let enterUrlTextField = app.textFields["Enter URL"]
        enterUrlTextField.tap()
        enterUrlTextField.typeText("https://www.relay.fm/radar/feed")

        waitForExpectations(timeout: 2.0) { (err) in
            XCTAssert(app.staticTexts["Under The Radar"].exists)
        }

    }
    
}
