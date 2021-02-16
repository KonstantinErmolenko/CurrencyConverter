//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Ермоленко Константин on 16.02.2021.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testStartingScreenIsConverter() throws {
        let title = app.navigationBars["Converter"]
        XCTAssertTrue(title.exists)
    }
}
