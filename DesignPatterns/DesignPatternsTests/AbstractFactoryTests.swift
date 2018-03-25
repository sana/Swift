//
//  AbstractFactoryTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/25/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class AbstractFactoryTests : XCTestCase {
    func testIntegerNumberFactory() {
        let integerFactory = AbstractFactory.factoryFor(numberType: NumberType.IntegerNumber)
        XCTAssertEqual(integerFactory("123.43").doubleValue(), 123)
    }

    func testRealNumberFactory() {
        let realFactory = AbstractFactory.factoryFor(numberType: NumberType.RealNumber)
        XCTAssertEqual(realFactory("123.43").doubleValue(), 123.43, accuracy: 0.001)
    }
}


