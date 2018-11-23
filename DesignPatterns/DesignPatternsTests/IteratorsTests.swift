//
//  IteratorsTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/22/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

class IteratorsTests : XCTestCase {
    func testConstantIterator() {
        var constantIterator = ConstantIterator()
        let kIterationsCount = 10
        for _ in 0..<kIterationsCount {
            guard let value = constantIterator.next() else {
                fatalError()
            }
            XCTAssertEqual(value, 1)
        }
    }

    func testFibonacciIterator() {
        var fibIterator = FibonacciIterator()
        let kIterationsCount = 10
        let fibonacciArray = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
        for index in 0..<kIterationsCount {
            guard let value = fibIterator.next() else {
                fatalError()
            }
            XCTAssertEqual(value, fibonacciArray[index])
        }
    }

    func testPrefixIterator() {
        let expectedSwiftPrefixes = ["S", "Sw", "Swi", "Swif", "Swift"]
        var prefixIterator = PrefixIterator(string: "Swift")
        var index = 0
        while let value = prefixIterator.next() {
            XCTAssertEqual(value, expectedSwiftPrefixes[index])
            index = index + 1
        }

        let expectedObjectiveCPrefixes = ["O", "Ob", "Obj", "Obje", "Objec", "Object", "Objecti", "Objectiv", "Objective", "ObjectiveC"]
        let prefixSequence = PrefixSequence(string: "ObjectiveC")
        for (prefix, expectedPrefix) in zip(prefixSequence, expectedObjectiveCPrefixes) {
            XCTAssertEqual(prefix, expectedPrefix)
        }
    }
}
