//
//  FutureTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class SimpleFutureResult : FutureResult, CustomStringConvertible {
    var description: String {
        return NSStringFromClass(type(of: self))
    }
}

class ComplexFutureResult : FutureResult, CustomStringConvertible {
    var description: String {
        return NSStringFromClass(type(of: self))
    }
}


class SimpleFuture : Future {
    override func begin() -> Future? {
        return self
    }
    
    override func wait() -> FutureResult? {
        return SimpleFutureResult()
    }
}

class ComplexFuture : Future {
    private let worktime: UInt32

    init(worktime: UInt32, completionCallback: FutureCompletionCallbackType?) {
        self.worktime = worktime
        super.init(completionCallback: completionCallback)
    }
    
    override func begin() -> Future? {
        return self
    }
    
    override func wait() -> FutureResult? {
        sleep(worktime)
        return ComplexFutureResult()
    }
}

class FutureTests : XCTestCase {
    var completionCallbackCalled = false

    func simpleCompletionCallback(result: FutureResult) -> Void {
        completionCallbackCalled = true
    }

    var completionCallbackCalledCount: Int = 0

    func anotherSimpleCompletionCallback(result: FutureResult) -> Void {
        completionCallbackCalledCount = completionCallbackCalledCount + 1
    }

    override func setUp() {
        completionCallbackCalled = false
        completionCallbackCalledCount = 0
    }
    
    func testSingleSimpleFutureExample() {
        let future: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()
        XCTAssert(manager.submit(future: future))
        sleep(1)
        XCTAssert(completionCallbackCalled)
    }
    
    func testMultipleSimpleFutureExample() {
        let future1: Future = SimpleFuture(completionCallback: anotherSimpleCompletionCallback)
        let future2: Future = SimpleFuture(completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()
        XCTAssert(manager.submit(future: future1))
        XCTAssert(manager.submit(future: future2))
        XCTAssert(manager.waitForAllFutureToComplete())
        XCTAssertEqual(completionCallbackCalledCount, 2)
    }
    
    func testSingleComplexFutureExample() {
        let future: Future = ComplexFuture(worktime: 2, completionCallback: simpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()
        XCTAssert(manager.submit(future: future))
        sleep(1)
        XCTAssertFalse(completionCallbackCalled)
        sleep(2)
        XCTAssert(completionCallbackCalled)
    }
    
    func testMultipleComplexFutureExample() {
        let future1: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 2, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()
        XCTAssert(manager.submit(future: future1))
        XCTAssert(manager.submit(future: future2))
        XCTAssertEqual(completionCallbackCalledCount, 0)
        XCTAssert(manager.waitForAllFutureToComplete())
        XCTAssertEqual(completionCallbackCalledCount, 2)
    }
    
    func testMixedFutureExample() {
        let future1: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()

        XCTAssertEqual(completionCallbackCalledCount, 0)
        XCTAssertFalse(completionCallbackCalled)

        XCTAssert(manager.submit(future: future1))
        XCTAssert(manager.submit(future: future2))

        XCTAssert(manager.waitForAllFutureToComplete())
        
        XCTAssertEqual(completionCallbackCalledCount, 1)
        XCTAssert(completionCallbackCalled)
    }

    func testMixedFutureWithMultipleQueuesExample() {
        let future1: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager()

        XCTAssertEqual(completionCallbackCalledCount, 0)
        XCTAssertFalse(completionCallbackCalled)

        XCTAssert(manager.submit(future: future1, queue: QOS_CLASS_USER_INTERACTIVE))
        XCTAssert(manager.submit(future: future2, queue: QOS_CLASS_USER_INITIATED))

        XCTAssert(manager.waitForFuturesToComplete(queue: QOS_CLASS_USER_INTERACTIVE))
        XCTAssert(manager.waitForFuturesToComplete(queue: QOS_CLASS_USER_INITIATED))
        
        XCTAssertEqual(completionCallbackCalledCount, 1)
        XCTAssert(completionCallbackCalled)
    }
}
