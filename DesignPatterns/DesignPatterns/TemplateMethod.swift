//
//  TemplateMethod.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Define a skeleton of an algorithm in an operation, deferring some steps to
 subclasses. Template Method lets subclasses redefine certain steps of an
 algorithm without changing the algorithm's structure.
 */
protocol AbstractSentenseComposer {
    func who() -> String
    func did() -> String
    func what() -> String
}

extension AbstractSentenseComposer {
    // this is the actual template method and it combines various abstract
    // method calls into a single step of an algorithm
    func sentense() -> String {
        return "\(who()) \(did()) \(what())"
    }
}

class DummySentenseComposer : AbstractSentenseComposer {
    func who() -> String {
        return "I"
    }
    
    func did() -> String {
        return "ate"
    }
    
    func what() -> String {
        return "a big burger"
    }
}

class SmartSentenseComposer : AbstractSentenseComposer {
    func who() -> String {
        return "Someone"
    }
    
    func did() -> String {
        return "studied"
    }
    
    func what() -> String {
        return "the design patterns book"
    }
}