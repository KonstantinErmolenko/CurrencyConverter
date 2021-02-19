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
        let secondCurrency = app.buttons["secondCurrency"]
        XCTAssertTrue(secondCurrency.exists)
    }

    func testAccessoryPanelConfiguredCorrectly() throws {
        let accessoryPanel = app.otherElements["accessoryPanel"]
        XCTAssertTrue(accessoryPanel.exists)
        let button1 = app.buttons["previousButton"]
        XCTAssertTrue(button1.exists, "The accessory panel must have a Previous button")
        let button2 = app.buttons["swapButton"]
        XCTAssertTrue(button2.exists, "The accessory panel must have a Swop button")
        let button3 = app.buttons["nextButton"]
        XCTAssertTrue(button3.exists, "The accessory panel must have a Next button")
    }

    func testKeyboardConfiguredCorrectly() throws {
        let keyboard = app.otherElements["keyboard"]
        XCTAssertTrue(keyboard.exists)
        
        for number in 0...9 {
            let numberButton = app.buttons["numberButton\(number)"]
            XCTAssertTrue(
                numberButton.exists,
                "The keyboard must have a button for the number \(number)"
            )
        }
        
        let commaButton = app.buttons["commaButton"]
        XCTAssertTrue(
            commaButton.exists,
            "The keyboard must have a comma button"
        )

        let deleteButton = app.buttons["deleteButton"]
        XCTAssertTrue(
            deleteButton.exists,
            "The keyboard must have a delete button"
        )
    }
}
