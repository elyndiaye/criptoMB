//
//  CriptoUITests.swift
//  queroserMBcriptoTests
//
//  Created by Ely Assumpcao Ndiaye on 03/05/25.
//

import XCTest

    final class CriptoListViewControllerUITests: XCTestCase {

        let app = XCUIApplication()

        override func setUpWithError() throws {
            continueAfterFailure = false
            app.launch()
        }

        func test_TableView_Appears_AfterLoading() {
            let activityIndicator = app.otherElements["SomeUniqueIdentifierForActivityIndicator"]
            let tableView = app.tables["CriptoListTableViewAccessibilityIdentifier"]

            let exists = NSPredicate(format: "exists == false")
            expectation(for: exists, evaluatedWith: activityIndicator, handler: nil)
            waitForExpectations(timeout: 5)
            XCTAssertTrue(tableView.exists)
            XCTAssertTrue(tableView.isHittable)
        }


        func test_ErrorDisplay_ShouldShowAlert() {
            
            let alert = app.alerts["Ops! Algo deu errado"] 

            let exists = NSPredicate(format: "exists == true")
            expectation(for: exists, evaluatedWith: alert, handler: nil)
            waitForExpectations(timeout: 5)

            XCTAssertTrue(alert.exists)
            XCTAssertTrue(alert.buttons["Tentar novamente"].exists)
        }
    }

