//
//  CollectionsTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/23/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

class CollectionsTests : XCTestCase {
    func testFIFOQueue() {
        var index = 0
        let expectedArray = [5, 10, 20]
        var queue = FIFOQueue<Int>()
        queue.enqueue(5)
        queue.enqueue(10)
        queue.enqueue(20)
        while let value = queue.dequeue() {
            XCTAssertEqual(value, expectedArray[index])
            index = index + 1
        }
    }

    func testFIFOQueueCollectionImplementation() {
        var queue = FIFOQueue<Int>()
        queue.enqueue(5)
        queue.enqueue(10)
        queue.enqueue(20)
        let expectedArray = [20, 10, 5]
        for (value, expectedValue) in zip(queue, expectedArray) {
            XCTAssertEqual(value, expectedValue)
        }
        XCTAssertEqual(queue.map({ String($0) }).joined(separator: ","), "20,10,5")
    }

    func testWordsCollection() {
        let expectedArray = ["Hello", "there", "my", "name", "is", "Tom"]
        let words = Words("Hello there my name is Tom")
        for (word, expectedWord) in zip(words, expectedArray) {
            XCTAssertEqual(String(word), expectedWord)
        }
    }

    func testHighOrderFunctions() {
        let people = [
            Person(firstName: "Zzz", lastName: "Bar3", yearOfBirth: 1987),
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 2000),
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 1990),
            Person(firstName: "Foo", lastName: "Bar0", yearOfBirth: 1988)
        ]
        let firstNameDescriptor = sortDescriptor(
            key: { (key : Person) -> String in
                return key.firstName
            },
            by: { (lhs: String, rhs: String) -> Bool in
                return lhs.localizedStandardCompare(rhs) == .orderedAscending
            }
        )
        let lastNameDescriptor = sortDescriptor(
            key: { (key : Person) -> String in
                return key.lastName
            },
            by: { (lhs: String, rhs: String) -> Bool in
                return lhs.localizedStandardCompare(rhs) == .orderedAscending
            }
        )
        let yearOfBirthDescriptor = sortDescriptor(
            key: { (key : Person) -> Int in
                return key.yearOfBirth
            },
            by: { (lhs: Int, rhs: Int) -> Bool in
                return lhs < rhs
            }
        )
        let sortedPeopleByFirstName = people.sorted(by: firstNameDescriptor)
        XCTAssertEqual(sortedPeopleByFirstName, [
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 2000),
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 1990),
            Person(firstName: "Foo", lastName: "Bar0", yearOfBirth: 1988),
            Person(firstName: "Zzz", lastName: "Bar3", yearOfBirth: 1987)
        ])

        let sortingDescriptors = [
            firstNameDescriptor,
            lastNameDescriptor,
            yearOfBirthDescriptor
        ]
        let combinedSortingDescriptors = combine(sortDescriptors: sortingDescriptors)
        let sortedPeopleByMultipleDescriptors = people.sorted(by: combinedSortingDescriptors)
        XCTAssertEqual(sortedPeopleByMultipleDescriptors, [
            Person(firstName: "Foo", lastName: "Bar0", yearOfBirth: 1988),
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 1990),
            Person(firstName: "Foo", lastName: "Bar2", yearOfBirth: 2000),
            Person(firstName: "Zzz", lastName: "Bar3", yearOfBirth: 1987)
        ])
    }
}

struct Person {
    let firstName: String
    let lastName: String
    let yearOfBirth: Int
}

extension Person : Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.yearOfBirth == rhs.yearOfBirth
    }
}

extension Person : CustomStringConvertible {
    var description: String {
        return "(\(firstName) \(lastName) \(yearOfBirth))"
    }
}
