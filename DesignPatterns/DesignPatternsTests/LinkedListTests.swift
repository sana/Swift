//
//  LinkedListTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/22/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

class LinkedListTests : XCTestCase {
    func testBasicListImplementation() {
        let head = LinkedList.node(value: 5, next: LinkedList.node(value: 6, next: LinkedList.node(value: 7, next: .end)))
        let expectedArray = [5, 6, 7]
        XCTAssertEqual(head.asArray(), expectedArray)
    }

    func testConstListImplementation() {
        let list = LinkedList.end.cons(5).cons(6).cons(7).cons(8)
        let expectedArray = [8, 7, 6, 5]
        XCTAssertEqual(list.asArray(), expectedArray)
    }

    func testExpressibleByArrayLiteralImplementation() {
        let expectedArray = [1, 2, 3, 4]
        let list: LinkedList = [1, 2, 3, 4]
        XCTAssertEqual(list.asArray(), expectedArray)
    }

    func testPushPopImplementation() {
        let expectedArray =  [5, 1, 2, 3, 4]
        var list: LinkedList = [1, 2, 3, 4]
        list.push(5)
        XCTAssertEqual(list.asArray(), expectedArray)

        _ = list.pop()
        XCTAssertEqual(list.asArray(), [1, 2, 3, 4])
    }

    func testLinkedListSequenceImplementation() {
        let list: LinkedList = ["1", "2", "3", "4"]
        XCTAssertEqual(list.joined(separator: ","), "1,2,3,4")
        XCTAssert(list.contains("3"))
        XCTAssertFalse(list.contains("5"))
        XCTAssertEqual(list.compactMap({ Int($0) }), [1, 2, 3, 4])
    }
}
