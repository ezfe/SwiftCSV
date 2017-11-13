//
//  CSVTests.swift
//  CSVTests
//
//  Created by naoty on 2014/06/09.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

import XCTest
@testable import SwiftCSV

class CSVTests: XCTestCase {
    var csv: CSV!
    
    override func setUp() {
        csv = CSV(string: "id,name,age\n1,Alice,18\n2,Bob,19\n3,Charlie,20")
    }
    
    func testInit_makesHeader() {
        XCTAssertEqual(csv.header, ["id", "name", "age"])
    }
    
    func testInit_makesRows() {
        let ground: [[String: String]] = [
            ["id": "1", "name": "Alice", "age": "18"],
            ["id": "2", "name": "Bob", "age": "19"],
            ["id": "3", "name": "Charlie", "age": "20"]
        ]
        for (index, row) in csv.rows.enumerated() {
            XCTAssertEqual(row, ground[index])
        }
    }
    
    func testInit_whenThereAreIncompleteRows_makesRows() {
        csv = CSV(string: "id,name,age\n1,Alice,18\n2,Bob,19\n3,Charlie")
        let ground: [[String: String]] = [
            ["id": "1", "name": "Alice", "age": "18"],
            ["id": "2", "name": "Bob", "age": "19"],
            ["id": "3", "name": "Charlie", "age": ""]
        ]
        for (index, row) in csv.rows.enumerated() {
            XCTAssertEqual(row, ground[index])
        }
    }
    
    func testInit_whenThereAreCRLFs_makesRows() {
        csv = CSV(string: "id,name,age\r\n1,Alice,18\r\n2,Bob,19\r\n3,Charlie,20\r\n")
        let ground: [[String: String]] = [
            ["id": "1", "name": "Alice", "age": "18"],
            ["id": "2", "name": "Bob", "age": "19"],
            ["id": "3", "name": "Charlie", "age": "20"]
        ]
        for (index, row) in csv.rows.enumerated() {
            XCTAssertEqual(row, ground[index])
        }
    }
    
    func testInit_makesColumns() {
        let ground: [String: [String]] = [
            "id": ["1", "2", "3"],
            "name": ["Alice", "Bob", "Charlie"],
            "age": ["18", "19", "20"]
        ]
        for (key, value) in csv.columns {
            if let groundValue = ground[key] {
                XCTAssertEqual(value, groundValue)
            } else {
                XCTFail()
            }
        }
    }
    
    func testDescription() {
        XCTAssertEqual(csv.description, "id,name,age\n1,Alice,18\n2,Bob,19\n3,Charlie,20")
    }
//    
//    func testEnumerate() {
//        let expected = [
//            ["id": "1", "name": "Alice", "age": "18"],
//            ["id": "2", "name": "Bob", "age": "19"],
//            ["id": "3", "name": "Charlie", "age": "20"]
//        ]
//        var index = 0
//        csv.enumerateAsDict { row in
//            XCTAssertEqual(row, expected[index])
//            index += 1
//        }
//    }
    
    func testIgnoreColumns() {
        csv = CSV(string: "id,name,age\n1,Alice,18\n2,Bob,19\n3,Charlie,20", delimiter: ",", loadColumns: false)
        XCTAssertEqual(csv.columns.isEmpty, true)
        
        let ground: [[String: String]] = [
            ["id": "1", "name": "Alice", "age": "18"],
            ["id": "2", "name": "Bob", "age": "19"],
            ["id": "3", "name": "Charlie", "age": "20"]
        ]
        for (index, row) in csv.rows.enumerated() {
            XCTAssertEqual(row, ground[index])
        }
    }
    
    static var allTests = [
        ("testInit_makesHeaders", testInit_makesHeader),
        ("testInit_makesRows", testInit_makesRows),
        ("testInit_whenThereAreIncompleteRows_makesRows", testInit_whenThereAreIncompleteRows_makesRows),
        ("testInit_whenThereAreCRLFs_makesRows", testInit_whenThereAreCRLFs_makesRows),
        ("testInit_makesColumns", testInit_makesColumns),
        ("testDescription", testDescription),
//        ("testEnumerate", testEnumerate),
        ("testIgnoreColumns", testIgnoreColumns),
    ]
}
