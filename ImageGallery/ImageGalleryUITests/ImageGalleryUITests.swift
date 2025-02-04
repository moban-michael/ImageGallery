//
//  ImageGalleryUITests.swift
//  ImageGalleryUITests
//
//  Created by Moban Michael on 31/01/2021.
//

import XCTest

class ImageGalleryUITests: XCTestCase {

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
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testImageGalleryList() {
        
        let app = XCUIApplication()
        app.activate()
        let collectionViewsQuery = app.collectionViews
        let collectionView = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element
        let searchField = app.navigationBars["Images"]/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".staticTexts.matching(identifier: \"Images\").searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        searchField.tap()
        searchField.typeText("kitten")
        app.typeText("\r")
        
        collectionView.swipeDown()
        collectionView.swipeUp()
        collectionView.swipeDown()
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
    }
}
