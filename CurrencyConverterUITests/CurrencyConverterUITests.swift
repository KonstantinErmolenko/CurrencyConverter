//
//  ConverterViewControllerUITests.swift
//  ConverterViewControllerUITests
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import XCTest

class ConverterViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testConverterIsStartingScreen() throws {
        let title = app.navigationBars["Converter"]
        XCTAssertTrue(title.exists)
    }
    
    func testTwoCurrencyLabelExist() throws {
        let firstCurrency = app.buttons["firstCurrency"]
        XCTAssertTrue(firstCurrency.exists)
        XCTAssertEqual(firstCurrency.label, "USD", "First currency should be USD")
                
        let secondCurrency = app.buttons["secondCurrency"]
        XCTAssertTrue(secondCurrency.exists)
        XCTAssertEqual(secondCurrency.label, "RUB", "Second currency should be RUB")
    }
}
