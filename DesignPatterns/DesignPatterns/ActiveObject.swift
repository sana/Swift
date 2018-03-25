//
//  ActiveObject.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

typealias JobLogicCompletionCallbackType = (JobLogic) -> Void

/**
 The active object design pattern decouples method execution from method
 invocation that reside in their own thread of control. The goal is to introduce
 concurrency, by using asynchronous method invocation and a scheduler for
 handling requests. The pattern consists of the following elements:
   1. A proxy, which provides an interface towards clients with publicly
    accessible methods
   2. An interface which defines the method request on the active object
   3. A list of pending requests from clients
   4. A scheduler, which decides which request to execute next
   5. The implementation of the active object method
   6. A callback or a variable for the client to receive the result
 */
class ActiveObject {
    private var callback: JobLogicCompletionCallbackType?
    private var jobs: [JobLogic]
    private var shouldStopExecutingJobs: Bool
    private var dispatchQueue: DispatchQueue
    private var jobsInFlight: Int
    
    init(callback: JobLogicCompletionCallbackType?) {
        self.callback = callback
        jobs = []
        shouldStopExecutingJobs = false
        dispatchQueue = DispatchQueue(label: "queue.ldascalu", qos: DispatchQoS.background)
        jobsInFlight = 0
    }
    
    func invoke(jobLogic: JobLogic) {
        jobsInFlight = jobsInFlight + 1
        dispatchQueue.async {
            self.jobs.append(jobLogic)
        }
    }
    
    func start() {
        dispatchQueue.async {
            self.shouldStopExecutingJobs = false
            self.schedule()
        }
    }
    
    func stop() {
        self.shouldStopExecutingJobs = true
    }
    
    private func executeHighestPriorityJob() {
        assert(jobs.count > 0)
        
        var maxJobIndex = 0
        var jobIndex = 0
        var highestPriorityJobLogic = jobs[maxJobIndex]
        var maxJobPriority = highestPriorityJobLogic.priority()
        for jobLogic in jobs {
            if (maxJobPriority < jobLogic.priority()) {
                maxJobPriority = jobLogic.priority()
                highestPriorityJobLogic = jobLogic
                maxJobIndex = jobIndex
            }
            jobIndex = jobIndex + 1
        }
        jobsInFlight = jobsInFlight - 1
        highestPriorityJobLogic.execute()
        jobs.remove(at: maxJobIndex)
        if let callback = self.callback {
            callback(highestPriorityJobLogic)
        }
    }
    
    private func schedule() {
        while (!self.shouldStopExecutingJobs && jobs.count > 0) {
            executeHighestPriorityJob()
        }
    }
    
    func areJobsInFlight() -> Bool {
        return self.jobsInFlight > 0
    }
}
