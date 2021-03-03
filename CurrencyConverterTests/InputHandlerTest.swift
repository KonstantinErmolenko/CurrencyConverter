//
//  InputHandlerTest.swift
//  CurrencyConverterTests
//
//  Created by Ермоленко Константин on 22.02.2021.
//

import XCTest
@testable import CurrencyConverter

class InputHandlerTest: XCTestCase {

    var sut: InputHandler!
    
    override func setUp() {
        super.setUp()
        sut = InputHandler()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Adding digit
    
    func testAddingFirstDigitWorksCorrectly() {
        var number = "0"
        number = sut.addDigit(digit: "3", to: number, maximumFractionDigits: 2)
        XCTAssertEqual(number, "3", "Adding new digit to whole number is incorrect")
    }
    
    func testAddingDigitToWholeNumberWorksCorrectly() {
        var number = "12"
        number = sut.addDigit(digit: "3", to: number, maximumFractionDigits: 2)
        XCTAssertEqual(number, "123", "Adding new digit to whole number is incorrect")
    }
    
    func testAddingDigitToDecimalNumberWorksCorrectly() {
        var number = "12,3"
        number = sut.addDigit(digit: "4", to: number, maximumFractionDigits: 2)
        XCTAssertEqual(number, "12,34", "Adding new digit to decimal number is incorrect")
    }
    
    func testResultValueformattedCorrectly() {
        var number = "100"
        number = sut.addDigit(digit: "1", to: number, maximumFractionDigits: 2)
        XCTAssertEqual(number, "1 001", "Result formatted incorrectly")
    }
    
    func testAddingDigitTakesIntoAccountTheNumberOfFractionDigitsForTheCurrency() {
        var number = "12,34"
        number = sut.addDigit(digit: "8",
                              to: number,
                              maximumFractionDigits: 2)
        XCTAssertEqual(number, "12,34", "Adding new digit doesn't take into account the number of decimal places for the currency")
        
        number = sut.addDigit(digit: "8",
                              to: number,
                              maximumFractionDigits: 3)
        XCTAssertEqual(number, "12,348", "Adding new digit doesn't take into account the number of decimal places for the currency")
    }
    
    func testAddingFirstDigitAfterCommaWorksCorrectly() {
        var number = "12,"
        number = sut.addDigit(digit: "3",
                              to: number,
                              maximumFractionDigits: 2)
        XCTAssertEqual(number, "12,3", "Adding new digit after comma is incorrect")
    }
    
    // MARK: - Adding comma
    
    func testAddingCommaToWholeNumberWorksCorrectly() {
        var number = "12"
        number = sut.addComma(to: number)
        XCTAssertEqual(number, "12,", "Adding comma to whole number is incorrect")
    }
    
    func testAddingCommaToDecimalNumberWorksCorrectly() {
        var number = "12,8"
        number = sut.addComma(to: number)
        XCTAssertEqual(number, "12,8", "Adding comma to decimal number is incorrect")
    }
    
    func testAddingMultipleCommasWorksCorrectly() {
        var number = "12,8"
        number = sut.addComma(to: number)
        number = sut.addComma(to: number)
        XCTAssertEqual(number, "12,8", "Adding multiple commas is incorrect")
    }
    
    // MARK: - Deleting symbol
    
    func testDeletingSymbolWorksCorrectly() {
        var number = "12,8"
        number = sut.deleteSymbol(from: number)
        XCTAssertEqual(number, "12,", "Deleting symbols is incorrect")
    }
    
    func testDeletingLastSymbolWorksCorrectly() {
        var number = "1"
        number = sut.deleteSymbol(from: number)
        XCTAssertEqual(number, "0", "Deleting last symbols is incorrect")
    }
    
    // MARK: - Converting string to number
    
    func testConvertingFromDecimalStringToNumberWorksCorrectly() {
        let str = "1 091,76"
        let result = sut.convertToNumber(string: str, maximumFractionDigits: 2)
        XCTAssertEqual(result, 1091.76, "Converting string to number is incorrect")
    }
    
    func testConvertingFromWholeStringWithExtraSpaceToNumberWorksCorrectly() {
        let str = "2 58"
        let result = sut.convertToNumber(string: str, maximumFractionDigits: 2)
        XCTAssertEqual(result, 258, "Converting string to number is incorrect")
    }
    
    func testConvertingFromDecimalNumberToStringWorksCorrectly() {
        let number = 1091.76
        let result = sut.convertToString(number: number, maximumFractionDigits: 2)
        XCTAssertEqual(result, "1 091,76", "Converting number to string is incorrect")
    }
    
    func testConvertingFromBigWholeNumberToStringWorksCorrectly() {
        let number = 1500000.0
        let result = sut.convertToString(number: number, maximumFractionDigits: 2)
        XCTAssertEqual(result, "1 500 000", "Converting number to string is incorrect")
    }
}
