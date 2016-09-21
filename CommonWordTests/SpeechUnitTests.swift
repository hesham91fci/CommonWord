//
//  SpeechUnitTests.swift
//  CommonWord
//
//  Created by IBM on 9/18/16.
//  Copyright © 2016 eGym. All rights reserved.
//

import XCTest

class SpeechUnitTests: XCTestCase {
    var speechProcessingViewController: SpeechProcessingViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        speechProcessingViewController = storyboard.instantiateViewControllerWithIdentifier("SpeechProcessingViewController") as! SpeechProcessingViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadFile(){
        let _ = speechProcessingViewController.view
        speechProcessingViewController.readSpeech()
        XCTAssert(speechProcessingViewController.errorThrown==false)
    }
    
    func testCommonWordCount(){
        self.testReadFile()
        speechProcessingViewController.calculateCommonWord()
        XCTAssert(speechProcessingViewController.commonWords.count != 0)
        XCTAssert(speechProcessingViewController.commonWordLabel.text?.characters.count>=3) // assert that the common word is not something like [of,am,are,is,in,etc...]
    }
    
    
}
