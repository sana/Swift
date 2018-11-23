//
//  FunctionsTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 2/24/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

fileprivate struct Address {
    let street: String
    let city: String
    let zipCode: Int
}

fileprivate struct User {
    let name: String
    let address: Address
}

class FunctionsTests : XCTestCase {

    // MARK :- Autoclosure

    func testAutoclosure() {
        let emptyArray = [Int]()
        XCTAssertFalse(Autoclosures.and(!emptyArray.isEmpty, emptyArray[0] > 0))

        let existingArray = [-5, 4, 3]
        XCTAssertFalse(Autoclosures.and(!existingArray.isEmpty, existingArray[0] > 0))

        let anotherExistingArray = [5, 4, 3]
        XCTAssert(Autoclosures.and(!anotherExistingArray.isEmpty, anotherExistingArray[0] > 0))
    }

    // Key Paths

    func testBasicKeyPathOperations() {
        let streetKeyPath = \User.address.street
        let nameKeyPath = \User.name

        let simpsonResidence = Address(street: "1094 Evergreen Terrace", city: "San Francisco", zipCode: 94113)
        let lisa = User(name: "Lisa", address: simpsonResidence)

        XCTAssertEqual(lisa[keyPath: nameKeyPath], "Lisa")
        XCTAssertEqual(lisa[keyPath: streetKeyPath], "1094 Evergreen Terrace")

        let nameCountKeyPath = nameKeyPath.appending(path: \.count)
        XCTAssertEqual(lisa[keyPath: nameCountKeyPath], 4)
    }
}
