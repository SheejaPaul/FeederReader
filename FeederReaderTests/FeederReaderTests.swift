//
//  FeederReaderTests.swift
//  FeederReaderTests
//
//  Created by Admin on 10/9/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import XCTest
@testable import FeederReader

class FeederReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFormattedSectionTitle() {
        let expectedString = "Top Stories"
        let sectionTitle = Styles().formattedSectionTitle(.home)
        XCTAssertEqual(expectedString, sectionTitle, "Expected string \(expectedString) is not equal to section title")
    }
    
    func testUrlEncodedString() {
        let expectedString = "top%20stories"
        let encodedString = Styles().urlEncodedString("top stories")
        XCTAssertEqual(expectedString, encodedString, "Expected string \(expectedString) is not equal to encoded string")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
