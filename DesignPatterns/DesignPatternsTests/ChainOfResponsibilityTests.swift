//
//  ChainOfResponsibilityTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/2/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class EvenPositiveNumbersHandler : EventHandlerChain {
    func handleEvent(event: Event) -> Bool {
        if (event.state < 0 || event.state % 2 == 1) {
            return false
        }
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

class ChainOfResponsibilityTests : XCTestCase {
    private let eventHandlerCenter: EventHandlerCenter = EventHandlerCenter(eventHandlerChain: OddPositiveNumbersHandler())

    func testPositiveOddNumberHandled() {
        let event1: Event = Event(state: 1)
        XCTAssert(eventHandlerCenter.handleEvent(event: event1))
    }

    func testPositiveEvenNumberHandled() {
        let event2: Event = Event(state: 2)
        XCTAssert(eventHandlerCenter.handleEvent(event: event2))
    }

    func testNegativeNumberNotHandled() {
        let event3: Event = Event(state: -5)
        XCTAssertFalse(eventHandlerCenter.handleEvent(event: event3))
    }

    func testZeroHandled() {
        let event4: Event = Event(state: 0)
        XCTAssert(eventHandlerCenter.handleEvent(event: event4))
    }
}
