//
//  DesignPatternsTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/24/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class StrategyTests: XCTestCase {
    func testLowerCaseStrategy() {
        let lowercasePrinter: Printer = Printer(printStrategy: LowercasePrintStrategy())
        XCTAssertEqual(lowercasePrinter.prepareForPrinting(string: "Hi!"), "hi!")
    }

    func testUpperCaseStrategy() {
        let uppercasePrinter: Printer = Printer(printStrategy: UppercasePrintStrategy())
        XCTAssertEqual(uppercasePrinter.prepareForPrinting(string: "Hi!"), "HI!")
    }
}
