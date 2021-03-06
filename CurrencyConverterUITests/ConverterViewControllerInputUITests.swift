//
//  ConverterViewControllerInputUITests.swift
//  CurrencyConverterUITests
//
//  Created by Ермоленко Константин on 23.02.2021.
//

import XCTest

class ConverterViewControllerInputUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testEnteringTheAmountOfTheFirstCurrencyCalculatesTheValueOfTheSecondCurrency() {
//        let currencyFrom = app.buttons["currencyFrom"].staticTexts["currencyValue"]
//        XCTAssertEqual(currencyFrom.label, "0", "Initial value of the first currency must be 0")
//        
//        let currencyTo = app.buttons["currencyTo"].staticTexts["currencyValue"]
//        XCTAssertEqual(currencyTo.label, "0", "Initial value of the second currency must be 0")
//        
//        app.buttons["digitButton1"].tap()
//        
//        XCTAssertEqual(currencyFrom.label, "1", "New value of the first currency must be 1")
//        XCTAssertEqual(currencyTo.label, "89,9219", "New value of the first currency must be 89,9219")
//        
//        app.buttons["digitButton2"].tap()
//        
//        XCTAssertEqual(currencyFrom.label, "12", "New value of the first currency must be 12")
//        XCTAssertEqual(currencyTo.label, "1 079,0628", "New value of the first currency must be 1 079,0628")
    }
    
    func testDeletingNuberInTheFirstCurrencyCalculatesTheValueOfTheSecondCurrency() {
//        let currencyFrom = app.buttons["currencyFrom"].staticTexts["currencyValue"]
//        XCTAssertEqual(currencyFrom.label, "0", "Initial value of the first currency must be 0")
//
//        let currencyTo = app.buttons["currencyTo"].staticTexts["currencyValue"]
//        XCTAssertEqual(currencyTo.label, "0", "Initial value of the second currency must be 0")
//
//        app.buttons["digitButton1"].tap()
//        app.buttons["digitButton2"].tap()
//
//        XCTAssertEqual(currencyFrom.label, "12", "New value of the first currency must be 12")
//        XCTAssertEqual(currencyTo.label, "1 079,0628", "New value of the first currency must be 1 079,0628")
//
//        app.buttons["deleteButton"].tap()
//        XCTAssertEqual(currencyFrom.label, "1", "The value of the first currency after deleting the symbol must be 1")
//        XCTAssertEqual(currencyTo.label, "89,9219", "The value of the second currency after deleting the symbol must be  89,9219")
//
//        app.buttons["deleteButton"].tap()
//        XCTAssertEqual(currencyFrom.label, "0", "The value of the first currency after deleting the symbol must be 0")
//        XCTAssertEqual(currencyTo.label, "0", "The value of the second currency after deleting the symbol must be 0")
    }
}
