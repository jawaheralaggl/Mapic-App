//
//  FlickrTests.swift
//  MapicTests
//
//  Created by Jawaher Alagel on 12/6/20.
//

@testable import Mapic
import XCTest

class FlickrTests: XCTestCase {
    
    let service = FlickrService()
    
    func testFlickrService() {
        // if equals, flick url is correct
        XCTAssertEqual(Constants.baseURLString, service.baseURLString)
        XCTAssertEqual(Constants.endPoint, service.endPoint)
        XCTAssertEqual(Constants.apiKey, service.apiKey)
        
        // apiKey must not be nil, otherwise the test fails
        XCTAssertNotNil(service.apiKey)
    }
    
    func testFlickrArrays()  {
        // arrays must not be nil, otherwise the test fails
        XCTAssertNotNil(service.picUrlArray)
        XCTAssertNotNil(service.pictureArray)
        XCTAssertNotNil(service.picTitleArray)
    }
    
    
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
    
    
    
}
