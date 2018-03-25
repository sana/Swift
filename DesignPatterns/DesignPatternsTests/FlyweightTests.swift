//
//  FlyweightTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/17/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class FlyweightTests : XCTestCase {
    func testFlyweightObjects() {
        let order1: Order = Order(table: "table1")
        order1.addItem(itemName: "plain coffee")
        order1.addItem(itemName: "plain coffee")
        order1.addItem(itemName: "plain coffee")
        XCTAssertEqual(order1.calories(), 30)

        let order2: Order = Order(table: "table2")
        order2.addItem(itemName: "simple coffee")
        order2.addItem(itemName: "plain coffee")
        order2.addItem(itemName: "choco coffee")
        XCTAssertEqual(order2.calories(), 330)

        let order3: Order = Order(table: "table3")
        order3.addItem(itemName: "own coffee")
        order3.addItem(itemName: "choco coffee")
        XCTAssertEqual(order3.calories(), 1120)
    }
}
