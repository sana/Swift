//
//  IteratorTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class IteratorTests : XCTestCase {
    func testSimpleIterator() {
        let list: IterableListOfLists = IterableListOfLists(data: [[1, 2, 3, 4, 5]])
        let expectedArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(Array(list), expectedArray)
    }

    func testMixedIterator() {
        let list: IterableListOfLists = IterableListOfLists(data: [[1, 2, 3], [4, 5]])
        let expectedArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(Array(list), expectedArray)
    }

    func testComplexIterator() {
        let list: IterableListOfLists = IterableListOfLists(data: [[1, 2, 3], [nil], [4], [], [5]])
        let expectedArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(Array(list), expectedArray)
    }

    func testDegeneratedIterator() {
        let list: IterableListOfLists = IterableListOfLists(data: [[nil], [nil, nil, 100], [nil]])
        let expectedArray = [100]
        XCTAssertEqual(Array(list), expectedArray)
    }
}
