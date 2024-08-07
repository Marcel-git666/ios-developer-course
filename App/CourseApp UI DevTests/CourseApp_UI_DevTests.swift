//
//  CourseApp_UI_DevTests.swift
//  CourseApp UI DevTests
//
//  Created by Marcel Mravec on 30.05.2024.
//

import XCTest

final class CourseApp_UI_DevTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment["UITEST"] = "1"
        app.launch()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Categories"].tap()
        tabBar.buttons["Random"].tap()
        tabBar.buttons["Profile"].tap()
        app.buttons["Onboarding"].tap()
        app.buttons["Dismiss onboarding"].tap()
        app.buttons["Logout"].tap()
        
        let eMailTextField = app.textFields["E-mail"]
        eMailTextField.tap()
        eMailTextField.typeText("marcel@marcel.cz")
        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        app.keyboards.buttons["Return"].tap()
        app.buttons["SignIn"].tap()
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
