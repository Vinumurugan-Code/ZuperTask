//
//  ModelTest.swift
//  ZuperTaskTests
//
//  Created by vinumurugan E on 20/03/22.
//

import XCTest
@testable import ZuperTask

class ModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
       let data = [Info(title: "New Title", author: "maxWell", tag: "iOS", is_completed: true, priority: "High", id: 555),
                   Info(title: "Demo", author: "John", tag: "Android", is_completed: false, priority: "LOW", id: 111),
                   Info(title: "", author: "", tag: "", is_completed: false, priority: "LOW", id: 999)]
       let results = Todo(data: data)
       XCTAssertNotNil(results)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
