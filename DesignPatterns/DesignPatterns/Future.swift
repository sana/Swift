//
//  Future.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 A future is an object containing a promise that some computation will terminate.
 The user submits a bunch of futures into a manager and gets notified when the
 futures are completed. The computation is part of the future object.
 
 In Swift, we use dispatch queues to wait for the futures, because dispatch
 queues are implemented with a thread pool and the user's computation in a
 future runs on such a thread (and not necessarily on the main thread).
 */
typealias FutureCompletionCallbackType = (FutureResult) -> Void

protocol FutureResult { }

class Future : Hashable {
    let completionCallback: FutureCompletionCallbackType?
    fileprivate var completed: Bool
    
    init(completionCallback: FutureCompletionCallbackType?) {
        self.completionCallback = completionCallback
        self.completed = false
    }

    func begin() -> Future? {
        return nil
    }
    
    func wait() -> FutureResult? {
        return nil
    }

    var hashValue : Int {
        get {
            return UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()).hashValue
        }
    }

    // Similar to calling future.begin() and future.wait() in a single call
    func accomplish() -> Bool {
        if let future = begin() {
            let result : FutureResult? = future.wait()
            if let result = result {
                if let completionCallback = completionCallback {
                    completionCallback(result)
                }
            }
            return true
        }
        return false
    }
}

func ==(left: Future, right: Future) -> Bool {
    return left.hashValue == right.hashValue
}

protocol FutureManager {
    func submit(future: Future, queue: qos_class_t) -> Bool
    func waitForFuturesToComplete(queue: qos_class_t) -> Bool
    func waitForAllFutureToComplete() -> Bool
}

class SimpleFutureManager : FutureManager {
    private var granularity: UInt32
    private var allFutures: [UInt32: Set<Future>]
    
    convenience init() {
        self.init(granularity: 1)
    }

    init(granularity: UInt32) {
        allFutures = [UInt32: Set<Future>]()
        self.granularity = granularity
    }
    
    func submit(future: Future) -> Bool {
        return submit(future: future, queue: QOS_CLASS_BACKGROUND)
    }
    
    func submit(future: Future, queue: qos_class_t) -> Bool {
        var futures: Set<Future>? = self.allFutures[queue.rawValue]
        if futures == nil {
            futures = Set<Future>()
            self.allFutures[queue.rawValue] = futures
        }
        
        if var futures = futures {
            if (futures.contains(future)) {
                return false
            }
            
            futures.insert(future)
            future.completed = false
            self.allFutures[queue.rawValue] = futures

            guard let qos = DispatchQoS.QoSClass(rawValue: queue) else {
                return false
            }
            DispatchQueue.global(qos: qos).async {
                _ = future.accomplish()
                future.completed = true
            }
            return true
        }
        return false
    }
    
    func waitForFuturesToComplete(queue: qos_class_t) -> Bool {
        var shouldWaitMore: Bool
        let futures : Set<Future>? = allFutures[queue.rawValue]
        if let futures  = futures {
            repeat {
                shouldWaitMore = false
                for future in futures {
                    if !future.completed {
                        shouldWaitMore = true
                    }
                }
                sleep(granularity)
            } while (shouldWaitMore)
            return true
        }
        return false
    }
    
    func waitForAllFutureToComplete() -> Bool {
        var result: Bool = true
        for queue in allFutures.keys {
            if (!waitForFuturesToComplete(queue: qos_class_t(queue))) {
                result = false
            }
        }
        return result
    }
}
