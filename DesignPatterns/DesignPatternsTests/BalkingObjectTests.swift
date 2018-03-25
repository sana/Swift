//
//  BalkingObjectTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class SimpleJobLogic : JobLogic {
    private let text: String
    private let expectation: XCTestExpectation

    init(text: String, expectation: XCTestExpectation) {
        self.text = text
        self.expectation = expectation
    }
    
    func execute() {
        guard !Thread.isMainThread else {
            return
        }
        DispatchQueue.main.async {
            self.expectation.fulfill()
        }
    }
    
    var description: String {
        return text
    }

    func priority() -> Int {
        return 0
    }
}

class ComplexJobLogic : SimpleJobLogic {
    var priorityValue: Int
    
    init(text: String, expectation: XCTestExpectation, priority: Int) {
        priorityValue = priority
        super.init(text: text, expectation: expectation)
    }
    
    override func priority() -> Int {
        return priorityValue
    }
}


class BalkingObjectTests : XCTestCase {
    func testSimpleExample() {
        let expectation1 = expectation(description: "first expectation")
        let simpleJobLogic1: JobLogic = SimpleJobLogic(text: "hello", expectation: expectation1)

        let expectation2 = expectation(description: "second expectation")
        let simpleJobLogic2: JobLogic = SimpleJobLogic(text: "this should not be printed", expectation: expectation2)

        let job: Job = Job()
        job.execute(jobLogic: simpleJobLogic1)
        job.execute(jobLogic: simpleJobLogic2)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testComplexExample() {
        let expectation1 = expectation(description: "first expectation")
        let complexJobLogic: JobLogic = ComplexJobLogic(text: "hello", expectation: expectation1, priority: 5)

        let expectation2 = expectation(description: "second expectation")
        let complexJobLogic2: JobLogic = ComplexJobLogic(text: "this should be printed", expectation: expectation2, priority: 10)

        let job: Job = Job()

        job.execute(jobLogic: complexJobLogic)
        sleep(1)

        job.execute(jobLogic: complexJobLogic2)
        sleep(1)

        waitForExpectations(timeout: 1, handler: nil)
    }
}
