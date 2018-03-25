//
//  ProxyTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 6/24/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class ProxyTests : XCTestCase {
    private static func addElements(toDatabase database: Database, fromDictionary dictionary: [AnyHashable : Any]) {
        let _ = database.begin()
        for (key, value) in dictionary {
            guard let keyAsString = key as? String else {
                continue
            }
            let _ = database.set(value: value, key: keyAsString)
        }
        let _ = database.commit()
    }

    func testSimpleDatabase() {
        let dictionary = [
            "key1" : "value1",
            "key2" : "value2",
            "key3" : "value3"
        ]
        let simpleDatabase: Database = SimpleDatabase()
        ProxyTests.addElements(toDatabase: simpleDatabase, fromDictionary: dictionary)
        for key in simpleDatabase.keys() {
            guard
                let value = simpleDatabase.get(key: key) as? String,
                let expectedValue = dictionary[key]
            else {
                XCTFail("Missing value for key \(key)")
                return
            }
            XCTAssertEqual(value, expectedValue)
        }
    }

    func testNSUserDefaultsDatabase() {
        let dictionary = [
            "key1" : "value1",
            "key2" : "value2",
            "key3" : "value3"
        ]
        let nsUserDefaultsDatabase: Database = NSUserDefaultsDatabase()
        ProxyTests.addElements(toDatabase: nsUserDefaultsDatabase, fromDictionary: dictionary)
        for key in dictionary.keys {
            guard
                let value = nsUserDefaultsDatabase.get(key: key) as? String,
                let expectedValue = dictionary[key]
            else {
                XCTFail("Missing value for key \(key)")
                return
            }
            XCTAssertEqual(value, expectedValue)
        }
    }

    func testProxyDatabaseWithoutForbiddenKeys() {
        let dictionary = [
            "key1" : "value1",
            "key2" : "value2",
            "key3" : "value3"
        ]
        let proxyDatabase: Database = ProxyDatabase(commitThreshold: 2, forbiddenKeys: nil)
        ProxyTests.addElements(toDatabase: proxyDatabase, fromDictionary: dictionary)
        for key in proxyDatabase.keys() {
            guard
                let value = proxyDatabase.get(key: key) as? String,
                let expectedValue = dictionary[key]
            else {
                XCTFail("Missing value for key \(key)")
                return
            }
            XCTAssertEqual(value, expectedValue)
        }
    }

    func testProxyDatabaseWithForbiddenKeys() {
        let dictionary = [
            "key1" : "value1",
            "key2" : "value2",
            "key3" : "value3"
        ]
        let forbiddenKeys = ["key1", "key2"]
        let proxyDatabase: Database = ProxyDatabase(commitThreshold: 2, forbiddenKeys: forbiddenKeys)
        ProxyTests.addElements(toDatabase: proxyDatabase, fromDictionary: dictionary)
        for key in proxyDatabase.keys() {
            guard
                let value = proxyDatabase.get(key: key) as? String,
                let expectedValue = dictionary[key]
            else {
                XCTFail("Missing value for key \(key)")
                return
            }
            XCTAssertEqual(value, expectedValue)
        }
        for forbiddenKey in forbiddenKeys {
            XCTAssertNil(proxyDatabase.get(key: forbiddenKey))
        }
    }
}
