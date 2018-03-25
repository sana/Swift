//
//  BuilderTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/25/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class BuilderTests : XCTestCase {
    private let stringNumbers = ["0.5", "2", "123.5", "-2.5", "-3.4"]

    func testIntegerNumberSequenceBuilder() {
        let integerFactory = AbstractFactory.factoryFor(numberType: NumberType.IntegerNumber)
        let result = NumbersSequenceBuilder.random(numbers: stringNumbers, forFactory: integerFactory)
        XCTAssertEqual(result, ["0.0", "2.0", "123.0", "-2.0", "-3.0"])
    }

    func testRealNumberSequenceBuilder() {
        let realFactory = AbstractFactory.factoryFor(numberType: NumberType.RealNumber)
        let result = NumbersSequenceBuilder.random(numbers: stringNumbers, forFactory: realFactory)
        let expectedResults = ["0.5", "2.0", "123.5", "-2.5", "-3.4"]
        XCTAssertEqual(result, expectedResults)
    }
}
