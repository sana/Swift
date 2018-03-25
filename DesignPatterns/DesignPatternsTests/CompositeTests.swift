//
//  CompositeTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class CompositeTests : XCTestCase {

    func testSimpleComposite() {
        let leafComposite = LeafComposite(value: IntegerNumber(integerNumber: 1))
        XCTAssertFalse(leafComposite.add(composite: leafComposite))
        for (lhs, rhs) in zip(leafComposite, [1.0]) {
            guard let lhsValue = lhs.value else {
                XCTFail("this line should never execute")
                return
            }
            XCTAssertEqual(lhsValue.doubleValue(), rhs)
        }
    }

    func testRecursiveComposite() {
        let firstRecursiveComposite = RecursiveComposite<IntegerNumber>()
        XCTAssert(firstRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 1))))
        XCTAssert(firstRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 2))))

        let leafComposite = LeafComposite(value: IntegerNumber(integerNumber: 3))

        let secondRecursiveComposite = RecursiveComposite<IntegerNumber>()
        XCTAssert(secondRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 4))))
        XCTAssert(secondRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 5))))

        let thirdRecursiveComposite = RecursiveComposite<IntegerNumber>()
        XCTAssert(thirdRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 6))))
        XCTAssert(thirdRecursiveComposite.add(composite: LeafComposite(value: IntegerNumber(integerNumber: 7))))
        XCTAssert(secondRecursiveComposite.add(composite: thirdRecursiveComposite))

        let root = RecursiveComposite<IntegerNumber>()
        XCTAssert(root.add(composite: firstRecursiveComposite))
        XCTAssert(root.add(composite: leafComposite))
        XCTAssert(root.add(composite: secondRecursiveComposite))

        for (lhs, rhs) in zip(root, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]) {
            guard let lhsValue = lhs.value else {
                XCTFail("this line should never execute")
                return
            }
            XCTAssertEqual(lhsValue.doubleValue(), rhs)
        }
    }
}
