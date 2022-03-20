//
//  ViewDataSourceTest.swift
//  ZuperTaskTests
//
//  Created by vinumurugan E on 20/03/22.
//

import XCTest
@testable import ZuperTask

class ViewDataSourceTest: XCTestCase {
    var dataSource = ListTableViewDataSource<Info>()
    
    override func setUp() {
        super.setUp()
        dataSource = ListTableViewDataSource<Info>()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        dataSource.data.value = []
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {  // Failed Test
        dataSource.data.value.append(Info(title: "New Title", author: "maxWell", tag: "iOS", is_completed: true, priority: "High", id: 555))
        dataSource.data.value.append(Info(title: "Demo", author: "John", tag: "Android", is_completed: false, priority: "LOW", id: 111))
        dataSource.data.value.append(Info(title: "", author: "", tag: "", is_completed: false, priority: "", id: 333))
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        dataSource.data.value.append(Info(title: "New Title", author: "maxWell", tag: "iOS", is_completed: true, priority: "High", id: 555))
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(TodoTableVCell.self, forCellReuseIdentifier: "TodoTableVCell")
        let indexPath = IndexPath(row: 0, section: 1)
        let cell = tableView.cellForRow(at: indexPath)
        XCTAssertNil(cell)
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "TodoTableVCell", for: indexPath) as! TodoTableVCell
        XCTAssertNotNil(cell1)
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
