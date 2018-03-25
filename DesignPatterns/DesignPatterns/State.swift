//
//  State.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Allow an object to alter its behavior when its internal state changes. The
 object will appear to change its class.
 */
enum State {
    case Inactive
    case Active
}

protocol StateDelegate {
    func state() -> String
}

class InactiveStateDelegate : StateDelegate {
    func state() -> String {
        return "inactive"
    }
}

class ActiveStateDelegate : StateDelegate {
    func state() -> String {
        return "active"
    }
}

protocol MutableStateDelegate : StateDelegate {
    func updateCurrentState(state: State)
}

class SimpleGreet : MutableStateDelegate {
    private var delegate: StateDelegate!
    
    init() {
        updateCurrentState(state: .Inactive)
    }
    
    func updateCurrentState(state: State) {
        switch(state) {
        case .Inactive:
            delegate = InactiveStateDelegate()
            break;
        case .Active:
            delegate = ActiveStateDelegate()
            break;
        }
    }

    func state() -> String {
        return delegate.state()
    }
}

class FancyGreet : MutableStateDelegate {
    private var delegates: [State: StateDelegate]
    private var currentState: State!
    
    init() {
        delegates = [State: StateDelegate]()
        delegates[.Inactive] = InactiveStateDelegate()
        delegates[.Active] = ActiveStateDelegate()
        updateCurrentState(state: .Inactive)
    }
    
    func updateCurrentState(state: State) {
        currentState = state
    }

    func state() -> String {
        return delegates[currentState]?.state() ?? ""
    }
}
