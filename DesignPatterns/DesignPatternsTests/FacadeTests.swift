//
//  FacadeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class FacadeTests : XCTestCase {

    func testUserDefaultsCacheImplementation() {
        let cacheImplementation: CacheFacade = UserDefaultsCacheImplementation()
        private_testBasic(cacheImplementation: cacheImplementation)
    }

    func testDictionaryCacheImplementation() {
        let cacheImplementation: CacheFacade = DictionaryCacheImplementation()
        private_testBasic(cacheImplementation: cacheImplementation)
    }

    func testConcurrentDictionaryCacheImplementation() {
        let concurrentQueue = DispatchQueue(label: "com.github.sana", attributes: .concurrent)
        let cacheImplementation: CacheFacade = DictionaryCacheImplementation()
        let count = 10000

        let group = DispatchGroup()

        concurrentQueue.async {
            group.enter()
            for i in 0 ... count {
                XCTAssert(cacheImplementation.set(value: "value\(i)", forKey: "key", ttl: nil))
            }
            group.leave()
        }

        concurrentQueue.async {
            group.enter()
            for i in 0 ... 2 * count {
                XCTAssert(cacheImplementation.set(value: "value\(i)", forKey: "key", ttl: nil))
            }
            group.leave()
        }

        group.notify(queue: .main) {
            XCTAssertNotNil(cacheImplementation.get(valueForKey: "key"))
        }
    }


    // MARK :- Private helpers

    private func private_testBasic(cacheImplementation: CacheFacade) {
        XCTAssertTrue(cacheImplementation.set(value: "bar", forKey: "foo", ttl: nil))
        XCTAssertTrue(cacheImplementation.set(value: "value", forKey: "key", ttl: nil))
        guard let value = cacheImplementation.get(valueForKey: "foo") else {
            XCTFail("Missing value for key")
            return
        }
        XCTAssertEqual(value, "bar")

        XCTAssert(cacheImplementation.delete(valueForKey: "key"))
        XCTAssertFalse(cacheImplementation.delete(valueForKey: "key"))

        XCTAssert(cacheImplementation.contains(key: "foo"))
        XCTAssertFalse(cacheImplementation.contains(key: "key"))

        XCTAssert(cacheImplementation.clear())
        XCTAssertFalse(cacheImplementation.clear())

        XCTAssert(cacheImplementation.set(multipleValuesForKeys: [
            (key: "key1", value: "value1"),
            (key: "key2", value: "value2"),
            (key: "key3", value: "value3")
        ]))

        let multipleGetResult = cacheImplementation.get(multipleValuesForKeys: ["key1", "key3", "key4"])
        let expectedMultipleGetResult = [("key1", "value1"), ("key3", "value3")]
        for (it1, it2) in zip(multipleGetResult, expectedMultipleGetResult) {
            XCTAssert(it1 == it2)
        }

        XCTAssertFalse(cacheImplementation.delete(multipleValuesForKeys: ["key1", "key2", "key4"]))
        XCTAssert(cacheImplementation.delete(multipleValuesForKeys: ["key3"]))
        XCTAssertFalse(cacheImplementation.clear())
    }
}

