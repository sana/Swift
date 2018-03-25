//
//  ChainOfResponsibility.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Avoid coupling the sender of a request to its receiver by giving more than one
 object a chance to handle the request. Chain the receiving objects and pass the
 request along the chain until an object handles it.
 */
class Event : CustomStringConvertible {
    var state: Int
    
    init(state: Int) {
        self.state = state
    }
    
    var description: String {
        return "Event \( state )"
    }
}

protocol EventHandler {
    func handleEvent(event: Event) -> Bool
}

protocol EventHandlerChain : EventHandler {
    var next: EventHandlerChain? { get set }
}

class EventHandlerCenter : EventHandler {
    let eventHandlerChain: EventHandlerChain?

    convenience init() {
        self.init(eventHandlerChain: nil)
    }
    
    init(eventHandlerChain: EventHandlerChain?) {
        self.eventHandlerChain = eventHandlerChain
    }
    
    func handleEvent(event: Event) -> Bool {
        var currentEventHandler: EventHandlerChain? = eventHandlerChain
        while (currentEventHandler != nil) {
            if let currentEventHandler = currentEventHandler {
                let result: Bool = currentEventHandler.handleEvent(event: event)
                if (result) {
                    return true
                }
            }
            currentEventHandler = currentEventHandler?.next ?? nil
        }
        return false
    }
}
