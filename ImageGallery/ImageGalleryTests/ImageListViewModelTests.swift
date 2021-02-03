//
//  ImageListViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Moban Michael on 03/02/2021.
//

import XCTest

@testable import ImageGallery

class ImageListViewModelTests: XCTestCase {
    
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
    
    func testGetImages() {
        
        var images: [Image]?
        
        let expected = expectation(description: "Wait to search to finish")
        _ = ImageListManager().getImageList(searchText: "Kitten").subscribe { (event) in
            
            if let downloadedImages = event.element {
                expected.fulfill()
                images = downloadedImages
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotEqual(0, images!.count)
    }
}
