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
    
    func testCurrencyButtonsAreConfiguredCorrectly() throws {
        let currencyFrom = app.buttons["currencyFrom"]
        XCTAssertTrue(currencyFrom.exists)
        let currencyTo = app.buttons["currencyTo"]
        XCTAssertTrue(currencyTo.exists)
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
                
        XCTAssertTrue(
            horizontalPositionOfButtons(looksLike: "previousButton", "swapButton", "nextButton"),
            "The accessory panel should look like previous, swap, next"
        )
    }
   
    func testAllKeyboardButtonsAreHittable() throws {
        for digit in 0...9 {
            let digitButton = app.buttons["digitButton\(digit)"]
            XCTAssertTrue(
                digitButton.isHittable,
                "The keyboard must have a button for the digit \(digit)"
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
            horizontalPositionOfButtons (looksLike: "digitButton1", "digitButton2", "digitButton3"),
            "The first row should look like 1, 2, 3"
        )
        XCTAssertTrue(
            horizontalPositionOfButtons (looksLike: "digitButton4", "digitButton5", "digitButton6"),
            "The second row should look like 4, 5, 6"
        )
        XCTAssertTrue(
            horizontalPositionOfButtons (looksLike: "digitButton7", "digitButton8", "digitButton9"),
            "The third row should look like 7, 8, 9"
        )
        XCTAssertTrue(
            horizontalPositionOfButtons (looksLike: "commaButton", "digitButton0", "deleteButton"),
            "The fourth row should look like comma, 0, delete"
        )
        
        XCTAssertTrue(
            verticalPositionOfButtons(looksLike: "digitButton1",
                                                  "digitButton4",
                                                  "digitButton7",
                                                  "commaButton"),
            "The first column should look like 1, 4, 7, comma"
        )
        XCTAssertTrue(
            verticalPositionOfButtons(looksLike: "digitButton2",
                                                  "digitButton5",
                                                  "digitButton8",
                                                  "digitButton0"),
            "The second column should look like 2, 5, 8, 0"
        )
        XCTAssertTrue(
            verticalPositionOfButtons(looksLike: "digitButton3",
                                                  "digitButton6",
                                                  "digitButton9",
                                                  "deleteButton"),
            "The third column should look like 3, 6, 9, delete"
        )
    }
    
    private func horizontalPositionOfButtons (looksLike buttons: String...) -> Bool {
        var coordinates = [CGFloat]()
        for button in buttons {
            coordinates.append(app.buttons[button].frame.midX)
        }

        return coordinateSequenceIsCorrect(coordinates: coordinates)
    }
    
    private func verticalPositionOfButtons (looksLike buttons: String...) -> Bool {
        var coordinates = [CGFloat]()
        for button in buttons {
            coordinates.append(app.buttons[button].frame.midY)
        }

        return coordinateSequenceIsCorrect(coordinates: coordinates)
    }
    
    private func coordinateSequenceIsCorrect(coordinates: [CGFloat]) -> Bool {
        let incorrect = stride(from: 0, to: coordinates.count - 1, by: 1)
                        .map { coordinates[$0] < coordinates[$0 + 1] }
                        .contains(false)
        
        return !incorrect
    }
}
