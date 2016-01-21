//
//  ActiveObjectTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/5/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

func completionCallback(jobLogic: JobLogic) -> Void {
    print("Completion callback for \( jobLogic )")
}

class ActiveObjectTests : SampleTest {
    class func runSamples() {
        let activeObject: ActiveObject = ActiveObject(callback: completionCallback)
        let jobLogic1: JobLogic = SimpleJobLogic(text: "job1")
        let jobLogic2: JobLogic = SimpleJobLogic(text: "job2")
        let jobLogic3: JobLogic = SimpleJobLogic(text: "job3")
        let jobLogic4: JobLogic = ComplexJobLogic(text: "job4", priority: 10)
        let jobLogic5: JobLogic = ComplexJobLogic(text: "job5", priority: 100)
        activeObject.invoke(jobLogic1)
        activeObject.invoke(jobLogic2)
        activeObject.start()
        activeObject.invoke(jobLogic3)
        activeObject.stop()
        activeObject.invoke(jobLogic4)
        activeObject.invoke(jobLogic5)
        activeObject.start()
        while (activeObject.areJobsInFlight()) {
            sleep(1)
        }
    }
}
