//
//  ConverterTest.swift
//  CurrencyConverterTests
//
//  Created by Ермоленко Константин on 23.02.2021.
//

import XCTest
@testable import CurrencyConverter

class ConverterTest: XCTestCase {

    var sut: Converter!
    
    override func setUp() {
        super.setUp()
        sut = Converter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testConvertingRateWorksCorrectly() {
        let amount = 12.5
        let rate = 90.98
        
        let result = sut.convert(amount: amount, byRate: rate)
        XCTAssertEqual(result, 1137.25, "Currency rate is calculated incorrectly")
    }
}
