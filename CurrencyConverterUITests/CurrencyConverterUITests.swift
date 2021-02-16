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
    
    func testCurrencyButtonsHaveCorrectTitles() throws {
        let firstCurrency = app.buttons["firstCurrency"]
        XCTAssertEqual(firstCurrency.label, "USD", "First currency should be USD")
                
        let secondCurrency = app.buttons["secondCurrency"]
        XCTAssertEqual(secondCurrency.label, "RUB", "Second currency should be RUB")
    }
    
    func testCurrencyButtonsAreConfiguredCorrectly() throws {
        let firstCurrency = app.buttons["firstCurrency"]
        XCTAssertTrue(firstCurrency.exists)
        XCTAssertEqual(
            firstCurrency.frame.size.height,
            120,
            "The height of the first currency button must be 120"
        )

        let secondCurrency = app.buttons["secondCurrency"]
        XCTAssertTrue(secondCurrency.exists)
        XCTAssertEqual(
            secondCurrency.frame.size.height,
            120,
            "The height of the second currency button must be 120"
        )
    }

    func testAccessoryPanelConfiguredCorrectly() throws {
        let accessoryPanel = app.otherElements["accessoryPanel"]
        XCTAssertTrue(accessoryPanel.exists)
        XCTAssertEqual(
            accessoryPanel.frame.size.height,
            60,
            "The height of the accessory panel must be 60"
        )
    }

    func testKeyboardConfiguredCorrectly() throws {
        let keyboard = app.otherElements["keyboard"]
        XCTAssertTrue(keyboard.exists)
    }
}
