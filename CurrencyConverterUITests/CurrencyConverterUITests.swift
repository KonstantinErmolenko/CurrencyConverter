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
   
    func testAllKeyboardButtonsIsHittable() throws {
        for number in 0...9 {
            let numberButton = app.buttons["numberButton\(number)"]
            XCTAssertTrue(
                numberButton.isHittable,
                "The keyboard must have a button for the number \(number)"
            )
        }
        
        let commaButton = app.buttons["commaButton"]
        XCTAssertTrue(
            commaButton.isHittable,
            "The keyboard must have a comma button"
        )

        let deleteButton = app.buttons["deleteButton"]
        XCTAssertTrue(
            deleteButton.isHittable,
            "The keyboard must have a delete button"
        )
    }

    func testallKeyboardButtonsAreLocatedCorrectly() throws {
        let keyboard = app.otherElements["keyboard"]
        XCTAssertTrue(keyboard.exists)

        XCTAssertTrue(
            horizontalPositionIsCorrect("numberButton1", "numberButton2", "numberButton3"),
            "The first row should look like 1, 2, 3"
        )
        XCTAssertTrue(
            horizontalPositionIsCorrect("numberButton4", "numberButton5", "numberButton6"),
            "The second row should look like 4, 5, 6"
        )
        XCTAssertTrue(
            horizontalPositionIsCorrect("numberButton7", "numberButton8", "numberButton9"),
            "The third row should look like 7, 8, 9"
        )
        XCTAssertTrue(
            horizontalPositionIsCorrect("commaButton", "numberButton0", "deleteButton"),
            "The fourth row should look like comma, 0, delete"
        )
        
        XCTAssertTrue(
            verticalPositionIsCorrect("numberButton1",
                                      "numberButton4",
                                      "numberButton7",
                                      "commaButton"),
            "The first column should look like 1, 4, 7, comma"
        )
        XCTAssertTrue(
            verticalPositionIsCorrect("numberButton2",
                                      "numberButton5",
                                      "numberButton8",
                                      "numberButton0"),
            "The second column should look like 2, 5, 8, 0"
        )
        XCTAssertTrue(
            verticalPositionIsCorrect("numberButton3",
                                      "numberButton6",
                                      "numberButton9",
                                      "deleteButton"),
            "The third column should look like 3, 6, 9, delete"
        )
    }
    
    func horizontalPositionIsCorrect (_ button1: String,
                                      _ button2: String,
                                      _ button3: String) -> Bool {
        let button1 = app.buttons[button1].frame.midX
        let button2 = app.buttons[button2].frame.midX
        let button3 = app.buttons[button3].frame.midX
        
        return button1 < button2 && button2 < button3
    }
    
    func verticalPositionIsCorrect (_ button1: String,
                                    _ button2: String,
                                    _ button3: String,
                                    _ button4: String) -> Bool {
        let button1 = app.buttons[button1].frame.midY
        let button2 = app.buttons[button2].frame.midY
        let button3 = app.buttons[button3].frame.midY
        let button4 = app.buttons[button4].frame.midY

        let result = button1 < button2
                     && button2 < button3
                     && button3 < button4
        
        return result
    }
}
