//
//  ActiveObjectTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class ActiveObjectTests : XCTestCase {
    func completionCallback(jobLogic: JobLogic) -> Void { }

    func testActiveObjects() {
        let activeObject: ActiveObject = ActiveObject(callback: completionCallback)

        let expectation1 = expectation(description: "first expectation")
        let jobLogic1: JobLogic = SimpleJobLogic(text: "job1", expectation: expectation1)

        let expectation2 = expectation(description: "second expectation")
        let jobLogic2: JobLogic = SimpleJobLogic(text: "job2", expectation: expectation2)

        let expectation3 = expectation(description: "third expectation")
        let jobLogic3: JobLogic = SimpleJobLogic(text: "job3", expectation: expectation3)

        let expectation4 = expectation(description: "forth expectation")
        let jobLogic4: JobLogic = ComplexJobLogic(text: "job4", expectation: expectation4, priority: 10)

        let expectation5 = expectation(description: "fifth expectation")
        let jobLogic5: JobLogic = ComplexJobLogic(text: "job5", expectation: expectation5, priority: 100)

        activeObject.invoke(jobLogic: jobLogic1)
        activeObject.invoke(jobLogic: jobLogic2)
        activeObject.start()
        activeObject.invoke(jobLogic: jobLogic3)
        activeObject.stop()
        activeObject.invoke(jobLogic: jobLogic4)
        activeObject.invoke(jobLogic: jobLogic5)
        activeObject.start()

        wait(for: [expectation1, expectation2, expectation3, expectation4, expectation5], timeout: 1)

        XCTAssertFalse(activeObject.areJobsInFlight())
    }
}
