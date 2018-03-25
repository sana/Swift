//
//  SingletonTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class SingletonTests : XCTestCase {
    func testSingletonInstancesAreIdentical() {
        guard let firstSingleton = Singleton.sharedInstance() else {
            XCTFail("Singleton.sharedInstance() failed")
            return
        }
        guard let secondSingleton = Singleton.sharedInstance() else {
            XCTFail("Singleton.sharedInstance() failed")
            return
        }
        XCTAssert(firstSingleton === secondSingleton)
    }

    func testMultitonInstancesAreIdenticalForTheSameKey() {
        guard let firstSingleton = Multiton.getInstance(key: "foo") else {
            XCTFail("Multiton.sharedInstance() failed")
            return
        }
        guard let secondSingleton = Multiton.getInstance(key: "foo") else {
            XCTFail("Multiton.sharedInstance() failed")
            return
        }
        XCTAssert(firstSingleton === secondSingleton)
    }

    func testMultitonInstancesAreNotIdenticalForDifferentKeys() {
        guard let firstSingleton = Multiton.getInstance(key: "foo") else {
            XCTFail("Multiton.sharedInstance() failed")
            return
        }
        guard let secondSingleton = Multiton.getInstance(key: "bar") else {
            XCTFail("Multiton.sharedInstance() failed")
            return
        }
        XCTAssert(firstSingleton !== secondSingleton)
    }

    func testSingletonPerformance() {
        let numberOfTimes: Int64 = 1000000
        XCTAssertGreaterThanOrEqual(self.executeThreadSafeSingletonMethod(forNumberOfTimes: numberOfTimes), self.executeMainThreadSingletonMethod(forNumberOfTimes: numberOfTimes))
    }

    func testMultitonPerformance() {
        let numberOfTimes: Int64 = 1000000
        XCTAssertGreaterThanOrEqual(self.executeThreadSafeMultitonMethod(forNumberOfTimes: numberOfTimes), self.executeMainThreadMultitonMethod(forNumberOfTimes: numberOfTimes))
    }

    // MARK :- Private Helpers

    private func executeThreadSafeSingletonMethod(forNumberOfTimes numberOfTimes: Int64) -> TimeInterval {
        let methodStart = Date()
        for _ in 1...numberOfTimes {
            guard Singleton.sharedInstance() != nil else {
                XCTFail("Singleton.sharedInstance() failed")
                return 0
            }
        }
        let methodFinish = Date()
        return methodFinish.timeIntervalSince(methodStart)
    }


    private func executeMainThreadSingletonMethod(forNumberOfTimes numberOfTimes: Int64) -> TimeInterval {
        let methodStart = Date()
        for _ in 1...numberOfTimes {
            guard MainThreadSingleton.sharedInstance() != nil else {
                XCTFail("MainThreadSingleton.sharedInstance() failed")
                return 0
            }
        }
        let methodFinish = Date()
        return methodFinish.timeIntervalSince(methodStart)
    }


    private func executeThreadSafeMultitonMethod(forNumberOfTimes numberOfTimes: Int64) -> TimeInterval {
        let methodStart = Date()
        for _ in 1...numberOfTimes {
            let key = String.random(length: 3)
            guard Multiton.getInstance(key: key) != nil else {
                XCTFail("Multiton.getInstance(key) failed")
                return 0
            }
        }
        let methodFinish = Date()
        return methodFinish.timeIntervalSince(methodStart)
    }


    private func executeMainThreadMultitonMethod(forNumberOfTimes numberOfTimes: Int64) -> TimeInterval {
        let methodStart = Date()
        for _ in 1...numberOfTimes {
            let key = String.random(length: 3)
            guard MainThreadMultiton.getInstance(key: key) != nil else {
                XCTFail("MainThreadMultiton.getInstance(key) failed")
                return 0
            }
        }
        let methodFinish = Date()
        return methodFinish.timeIntervalSince(methodStart)
    }
}
