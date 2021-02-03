//
//  ImageTests.swift
//  ImageGalleryTests
//
//  Created by Moban Michael on 03/02/2021.
//

import XCTest

@testable import ImageGallery

class ImageTests: XCTestCase {
    
    let image = Image(imageID: "12",title: "testImage", farm: 2, server: "testServer", secret: "testSecret")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPhotoURL(){
        XCTAssertEqual(UrlUtlis.getImageURL(size: "m", image: image)?.absoluteString, "https://farm2.staticflickr.com/testServer/12_testSecret_m.jpg")
    }
    
    func testInstantiation() {
        XCTAssertEqual(image.imageID, "12")
        XCTAssertEqual(image.title, "testImage")
        XCTAssertEqual(image.secret, "testSecret")
        XCTAssertEqual(image.server, "testServer")
        XCTAssertEqual(image.farm, 2)
    }
}
