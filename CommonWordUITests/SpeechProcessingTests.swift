//
//  SpeechProcessingTests.swift
//  CommonWord
//
//  Created by IBM on 9/18/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import XCTest

class SpeechProcessingTests: XCTestCase {
        
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
    
    func testProgressBarIncremental(){
        let app = XCUIApplication()
        let firstCell = app.tables.staticTexts["Steve Jobs"].tap()
        sleep(3)
        XCTAssert(app.staticTexts["0.0%"].exists == false)
    }
    
}
