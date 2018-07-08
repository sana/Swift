//
//  LRUCacheTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 7/7/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class LRUCacheTests : XCTestCase {
    func testSimpleCache() {
        let cache = LRUCache(size: 5)
        XCTAssert(cache.set(value: "one", forKey: "one"))
        XCTAssert(cache.set(value: "two", forKey: "two"))
        XCTAssert(cache.set(value: "three", forKey: "three"))
        XCTAssert(cache.set(value: "four", forKey: "four"))
        XCTAssert(cache.set(value: "five", forKey: "five"))
        XCTAssertFalse(cache.set(value: "six", forKey: "six")) // we have to remove the least recently used key, i.e. `one`
        XCTAssertEqual(cache.dictionary(), ["two" : "two", "three" : "three", "four" : "four", "five" : "five", "six" : "six"])
    }

    func testFirstKeyUsedAgainCache() {
        let cache = LRUCache(size: 5)
        XCTAssert(cache.set(value: "one", forKey: "one"))
        XCTAssert(cache.set(value: "two", forKey: "two"))
        XCTAssert(cache.set(value: "three", forKey: "three"))
        XCTAssert(cache.set(value: "four", forKey: "four"))
        XCTAssert(cache.set(value: "five", forKey: "five"))
        XCTAssertFalse(cache.set(value: "oneUpdated", forKey: "one"))
        XCTAssertFalse(cache.set(value: "six", forKey: "six")) // we have to remove the least recently used key, i.e. `two`
        XCTAssertEqual(cache.dictionary(), ["one" : "oneUpdated", "three" : "three", "four" : "four", "five" : "five", "six" : "six"])
    }
}
