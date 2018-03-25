//
//  VisitorTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/3/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class VisitorCenter {
    private let objects: [VisiteableObject] = [
        NumberObject(number: 1),
        StringObject(string: "2"),
        NumberObject(number: 3),
        StringObject(string: "4"),
        NumberObject(number: 5),
    ]

    func visitObjects(visitor: Visitor) {
        for object in objects {
            object.accept(visitor: visitor)
        }
    }
}

class SimpleVisitor : Visitor {
    fileprivate var aggregateString: String

    init() {
        aggregateString = ""
    }

    func visit(numberValue number: Int) {
        visit(stringValue: String(number))
    }

    func visit(stringValue string: String) {
        aggregateString = aggregateString + "|" + string
    }
}

class AggregateVisitor : Visitor, CustomStringConvertible {
    fileprivate var total: Int

    init() {
        total = 0
    }

    func visit(numberValue number: Int) {
        total += number
    }

    func visit(stringValue string: String) {
        total += Int(string) ?? 0
    }

    var description: String {
        return "Total \( String(total) )"
    }
}

class VisitorTests : XCTestCase {
    private let visitorCenter : VisitorCenter = VisitorCenter()

    func testVisitorCenterWithSimpleVisitor() {
        let simpleVisitor : SimpleVisitor = SimpleVisitor()
        XCTAssertEqual(simpleVisitor.aggregateString, "")
        visitorCenter.visitObjects(visitor: simpleVisitor)
        XCTAssertEqual(simpleVisitor.aggregateString, "|1|2|3|4|5")
    }

    func testVisitorCenterWithAggregateVisitor() {
        let aggregateVisitor : AggregateVisitor = AggregateVisitor()
        XCTAssertEqual(aggregateVisitor.total, 0)
        visitorCenter.visitObjects(visitor: aggregateVisitor)
        XCTAssertEqual(aggregateVisitor.total, 15)
    }
}
