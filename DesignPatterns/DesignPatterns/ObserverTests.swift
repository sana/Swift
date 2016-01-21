//
//  ObserverTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class ObserverTests : SampleTest {
    class func testBasicSubjectObserver() {
        let subject1: Subject = Subject(id: "subject1")
        let subject2: Subject = Subject(id: "subject2")
        let observer1: Observer = Observer(id: "observer1")
        let observer2: Observer = Observer(id: "observer2")
        let observer3: Observer = Observer(id: "observer3")
        let observer4: Observer = Observer(id: "observer4")
        
        subject1.attach(observer1)
        subject2.attach(observer1)

        subject1.attach(observer2)
        subject2.attach(observer2)

        subject1.attach(observer3)
        subject2.attach(observer3)
        
        subject1.attach(observer4)
        subject2.attach(observer4)

        subject2.notify()
        
        subject2.detach(observer3)

        subject2.notify()
    }
    
    class func testCircularDependency() {
        let subject1: Subject = Subject(id: "subject1")
        let subject2: Subject = Subject(id: "subject2")
        let subject3: Subject = Subject(id: "subject3")
        
        subject1.attach(subject2)
        subject2.attach(subject3)
        subject3.attach(subject1)
        
        subject1.notify()
    }
    
    class func runSamples() {
        testBasicSubjectObserver()
        testCircularDependency()
    }
}