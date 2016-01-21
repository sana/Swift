//
//  ChainOfResponsibilityTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class EvenPositiveNumbersHandler : EventHandlerChain {
    func handleEvent(event: Event) -> Bool {
        if (event.state < 0 || event.state % 2 == 1) {
            return false
        }
        print("[handleEvent] \( NSStringFromClass(self.dynamicType) ) \( event.state )")
        return true
    }

    var next: EventHandlerChain? {
        get {
            return nil
        }
        set {
            self.next = newValue
        }
    }
}

class OddPositiveNumbersHandler : EventHandlerChain {
    func handleEvent(event: Event) -> Bool {
        if (event.state < 0 || event.state % 2 == 0) {
            return false
        }
        print("[handleEvent] \( NSStringFromClass(self.dynamicType) ) \( event.state )")
        return true
    }
    
    var next: EventHandlerChain? {
        get {
            return EvenPositiveNumbersHandler()
        }
        set {
            self.next = newValue
        }
    }
}

class ChainOfResponsibilityTests : SampleTest {
    class func runSamples() {
        let eventHandlerCenter: EventHandlerCenter = EventHandlerCenter(eventHandlerChain: OddPositiveNumbersHandler())
        
        let event1: Event = Event(state: 1)
        print(eventHandlerCenter.handleEvent(event1))
        
        let event2: Event = Event(state: 2)
        print(eventHandlerCenter.handleEvent(event2))
        
        let event3: Event = Event(state: -5)
        print(eventHandlerCenter.handleEvent(event3))
        
        let event4: Event = Event(state: 0)
        print(eventHandlerCenter.handleEvent(event4))
    }
}