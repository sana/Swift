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
protocol AbstractSentenceComposer {
    func who() -> String
    func did() -> String
    func what() -> String
}

extension AbstractSentenceComposer {
    // this is the actual template method and it combines various abstract
    // method calls into a single step of an algorithm
    func sentence() -> String {
        return "\(who()) \(did()) \(what())"
    }
}
