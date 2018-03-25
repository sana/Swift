//
//  AdapterTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class AdapterTests : XCTestCase {
    func testIntArray() {
        let stack: ArrayStack = ArrayStack<Int>()
        let count = 5
        for i in 1...5 {
            stack.push(key: i)
        }

        var index = 0
        while (!stack.isEmpty()) {
            let item = stack.pop()
            XCTAssertEqual(item, count - index)
            index = index + 1
        }
    }
}
