//
//  PerformanceTest.swift
//  SwiftCSV
//
//  Created by 杉本裕樹 on 2016/04/23.
//  Copyright © 2016年 Naoto Kaneko. All rights reserved.
//

import XCTest
@testable import SwiftCSV

class PerformanceTest: XCTestCase {
    var csv: CSV!

    override func setUp() {
        print(Bundle(for: type(of: self)).bundleURL.absoluteString)
        let csvURL = Bundle(for: CSVTests.self).url(forResource: "large", withExtension: "csv")!
        csv = try! CSV(url: csvURL)
    }

    func testParsePerformance() {
        measure {
            _ = self.csv.rows
        }
    }
    
    static var allTests = [
        ("testParsePerformance", testParsePerformance)
    ]
}
