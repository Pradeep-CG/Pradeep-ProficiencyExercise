//
//  Pradeep_ProficiencyExerciseTests.swift
//  Pradeep-ProficiencyExerciseTests
//
//  Created by Pradeep on 07/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//
@testable import Pradeep_ProficiencyExercise
import XCTest

class ProficiencyExerciseTests: XCTestCase {

    var viewControllerUnderTest: CanadaViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewControllerUnderTest = CanadaViewController()
        // in view controller, menuItems = ["one", "two", "three"]
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDown")
    }
    func testApiUrlIsCorrect() {
        XCTAssertEqual(Constants.apiString, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    }
    func testVerifyApiUrl() {
        XCTAssertTrue(Common.verifyUrl(urlString: Constants.apiString))
    }
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.canadaTableView)
    }
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.canadaTableView.delegate)
    }
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.canadaTableView.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    func testGetApiDataWithExpectedURLHostAndPath() {
      let httpUtility = HttpUtility()
        httpUtility.getApiData(requestUrl: Constants.apiString, resultType: CanadaModel.self) { response in
            XCTAssertNotNil(response)
            XCTAssertFalse(response.rows.isEmpty)
            XCTAssertEqual(response.title, "About Canada")
        }
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
