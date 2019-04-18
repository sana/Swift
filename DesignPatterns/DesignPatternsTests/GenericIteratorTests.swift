//
//  GenericIteratorTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 4/17/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

class GenericIteratorTests : XCTestCase {

    // MARK :- IntIterator

    func testIntIterator() {
        let it: GenericIterator = GenericIterator(value: .value(value: 5))
        let result = collectItems(forIterator: it)
        XCTAssertEqual(result, [5])
    }

    // MARK :- ArrayIterator

    func testArrayIterator() {
        let it: GenericIterator = GenericIterator(value: .array(array: [.value(value: 1), .value(value: 2), .value(value: 3)]))
        let result = collectItems(forIterator: it)
        XCTAssertEqual(result, [1, 2, 3])
    }

    // Mark :- ArrayOfArraysIterator

    func testArrayOfArraysIterator() {
        let it: GenericIterator = GenericIterator(value: .array(array:
            [
                .array(array: [.value(value: 1), .value(value: 2)]),
                .array(array: [.value(value: 3), .value(value: 4)]),
                .array(array: [.value(value: 5), .value(value: 6)])
            ]
        ))
        let result = collectItems(forIterator: it)
        XCTAssertEqual(result, [1, 2, 3, 4, 5, 6])
    }

    // MARK :- ArrayOfAnyValuesIterator

    func testArrayOfAnyValuesIterator() {
        let it: GenericIterator = GenericIterator(value: .array(array:
            [
                .array(array: [.value(value: 1), .value(value: 5)]),
                .value(value: 2),
                .value(value: 3)
            ]
            ))
        let result = collectItems(forIterator: it)
        XCTAssertEqual(result, [1, 5, 2, 3])
    }

    // MARK :- Private Helpers

    private func collectItems<T>(forIterator it: GenericIterator<T>) -> [T] {
        var result = [T]()
        while let value = it.next() {
            result.append(value)
        }
        return result
    }
}
