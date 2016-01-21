//
//  BalkingObjectTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class SimpleJobLogic : JobLogic {
    private var text: String

    init(text: String) {
        self.text = text
    }
    
    func execute() {
        print(text)
    }
    
    func stringValue() -> String {
        return text
    }
    
    func priority() -> Int {
        return 0
    }
}

class ComplexJobLogic : SimpleJobLogic {
    var priorityValue: Int
    
    init(text: String, priority: Int) {
        priorityValue = priority
        super.init(text: text)
    }
    
    override func priority() -> Int {
        return priorityValue
    }
}


class BalkingObjectTests : SampleTest {
    class func simpleExample() {
        let simpleJobLogic1: JobLogic = SimpleJobLogic(text: "hello")
        let simpleJobLogic2: JobLogic = SimpleJobLogic(text: "this should not be printed")
        let job: Job = Job()
        job.execute(simpleJobLogic1)
        job.execute(simpleJobLogic2)
        sleep(1)
    }

    class func complexExample() {
        let simpleJobLogic1: JobLogic = SimpleJobLogic(text: "hello")
        let simpleJobLogic2: JobLogic = SimpleJobLogic(text: "this should be printed")
        let job: Job = Job()
        job.execute(simpleJobLogic1)
        sleep(1)
        job.execute(simpleJobLogic2)
        sleep(1)
    }
    
    class func runSamples() {
        simpleExample()
        complexExample()
    }
}
