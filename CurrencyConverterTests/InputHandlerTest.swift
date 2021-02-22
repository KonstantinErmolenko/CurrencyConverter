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
        number = sut.addDigit(digit: "3", to: number)
        XCTAssertEqual(number, "3", "Adding new digit to whole number is incorrect")
    }
    
    func testAddingDigitToWholeNumberWorksCorrectly() {
        var number = "12"
        number = sut.addDigit(digit: "3", to: number)
        XCTAssertEqual(number, "123", "Adding new digit to whole number is incorrect")
    }
    
    func testAddingDigitToDecimalNumberWorksCorrectly() {
        var number = "12,3"
        number = sut.addDigit(digit: "4", to: number)
        XCTAssertEqual(number, "12,34", "Adding new digit to decimal number is incorrect")
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
        XCTAssertEqual(number, "12,", "Deletilg symbols is incorrect")
    }
    
    func testDeletingLastSymbolWorksCorrectly() {
        var number = "1"
        number = sut.deleteSymbol(from: number)
        XCTAssertEqual(number, "0", "Deletilg last symbols is incorrect")
    }
}
