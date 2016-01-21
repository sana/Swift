//
//  FutureTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class SimpleFutureResult : FutureResult, PrintableClass {
    func stringValue() -> String {
        return NSStringFromClass(self.dynamicType)
    }
}

class ComplexFutureResult : FutureResult, PrintableClass {
    func stringValue() -> String {
        return NSStringFromClass(self.dynamicType)
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

var completionCallbackCalled = false

func simpleCompletionCallback(result: FutureResult) -> Void {
    print(result)
    completionCallbackCalled = true
}

var completionCallbackCalledCount = 0

func anotherSimpleCompletionCallback(result: FutureResult) -> Void {
    print(result)
    completionCallbackCalledCount++
}

class FutureTests : SampleTest {
    class func beforeEach() {
        completionCallbackCalled = false
        completionCallbackCalledCount = 0
    }
    
    class func runSingleSimpleFutureExample() {
        beforeEach()
        let future: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        manager.submit(future)
        sleep(1)
        assert(completionCallbackCalled)
    }
    
    class func runMultipleSimpleFutureExample() {
        beforeEach()
        let future1: Future = SimpleFuture(completionCallback: anotherSimpleCompletionCallback)
        let future2: Future = SimpleFuture(completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        manager.submit(future1)
        manager.submit(future2)
        manager.waitForAllFutureToComplete()
        assert(completionCallbackCalledCount == 2)
    }
    
    class func runSingleComplexFutureExample() {
        beforeEach()
        let future: Future = ComplexFuture(worktime: 2, completionCallback: simpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        manager.submit(future)
        sleep(1)
        assert(!completionCallbackCalled)
        sleep(2)
        assert(completionCallbackCalled)
    }
    
    class func runMultipleComplexFutureExample() {
        beforeEach()
        let future1: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 2, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        manager.submit(future1)
        manager.submit(future2)
        assert(completionCallbackCalledCount == 0)
        manager.waitForAllFutureToComplete()
        assert(completionCallbackCalledCount == 2)
    }
    
    class func runMixedFutureExample() {
        beforeEach()
        let future1: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        
        manager.submit(future1)
        manager.submit(future2)
        
        assert(completionCallbackCalledCount == 0)
        assert(!completionCallbackCalled)
        
        manager.waitForAllFutureToComplete()
        
        assert(completionCallbackCalledCount == 1)
        assert(completionCallbackCalled)
    }

    class func runMixedFutureWithMultipleQueuesExample() {
        beforeEach()
        
        let future1: Future = SimpleFuture(completionCallback: simpleCompletionCallback)
        let future2: Future = ComplexFuture(worktime: 1, completionCallback: anotherSimpleCompletionCallback)
        let manager: SimpleFutureManager = SimpleFutureManager(debug: true)
        
        manager.submit(future1, queue: QOS_CLASS_USER_INTERACTIVE)
        manager.submit(future2, queue: QOS_CLASS_USER_INITIATED)
        
        assert(completionCallbackCalledCount == 0)
        assert(!completionCallbackCalled)
        
        manager.waitForFuturesToComplete(QOS_CLASS_USER_INTERACTIVE)
        manager.waitForFuturesToComplete(QOS_CLASS_USER_INITIATED)
        
        assert(completionCallbackCalledCount == 1)
        assert(completionCallbackCalled)
    }
    
    class func runSamples() {
        runSingleSimpleFutureExample()
        runMultipleSimpleFutureExample()
        runSingleComplexFutureExample()
        runMultipleComplexFutureExample()
        runMixedFutureExample()
        runMixedFutureWithMultipleQueuesExample()
    }
}