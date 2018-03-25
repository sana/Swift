//
//  BalkingObject.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 The balking pattern is a software design pattern that only executes an action
 on an object when the object is in a particular state.
 
 class Job {
    excute() {
        sync(this) {
            if (running) {
                return;
            } else {
                running = YES;
            }
            // run the code
        }
    }
    reset() {
        sync(this) {
            running = NO;
        }
    }
 }
 */

protocol JobLogic : CustomStringConvertible {
    func execute() -> Void
    func priority() -> Int
}

class Job {
    private let serialQueue = DispatchQueue(label: "BalkingObject.serialQueue")
    private var currentExecutingJobLogic: JobLogic?
    private var running: Bool
    
    init() {
        running = false
    }
    
    private func privateExecute(jobLogic: JobLogic) {
        if (running) {
            return
        } else {
            running = true
        }
        currentExecutingJobLogic = jobLogic
        jobLogic.execute()
        privateReset()
    }
    
    private func privateReset() {
        running = false
        currentExecutingJobLogic = nil
    }
    
    /**
     execute() and reset() are actually dispatched on the background queue, thus
     they are more than thread safe, they happen serially one after another.
     
     To properly implement this design pattern, we need to use a semaphore, so
     to implement sync(this).
     */
    func execute(jobLogic: JobLogic) {
        serialQueue.async() {
            self.privateExecute(jobLogic: jobLogic)
        }
    }
    
    func reset() {
        serialQueue.async() {
            self.privateReset()
        }
    }
}
