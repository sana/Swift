//
//  DecoratorTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 4/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class DecoratorTests : XCTestCase {
    func testSimpleObject() {
        let simpleCoffee: Coffee = SimpleCoffee()
        XCTAssertEqual(simpleCoffee.ingredients(), ["coffee"])
    }

    func testSimpleDecoratedObject() {
        let simpleCoffee: Coffee = SimpleCoffee()
        let milkCoffee: Coffee = MilkCoffee(decoratedCoffee: simpleCoffee)
        XCTAssertEqual(milkCoffee.ingredients(), ["coffee", "milk"])
    }

    func testComplexDecoratedObject() {
        let simpleCoffee: Coffee = SimpleCoffee()
        let icedMocchaCoffee: IcedMocchaCoffee = IcedMocchaCoffee(decoratedCoffee: simpleCoffee)
        XCTAssertEqual(icedMocchaCoffee.ingredients(), ["coffee", "milk", "ice", "caramel"])
    }
}
