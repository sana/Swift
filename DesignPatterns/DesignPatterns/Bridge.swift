//
//  Bridge.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Intent: Decouple an abstraction from its implementation so that the two can vary
 independently.
 */

// MARK :- Protocols

protocol SourceProtocol {
    func name() -> String
}

protocol TargetProtocol {
    func tokens(string: String) -> [String]
}

// MARK :- Protocol implementations

class SourceClass : SourceProtocol {
    func name() -> String {
        return "I want to break free!"
    }
}

class TargetClass : TargetProtocol {
    func tokens(string: String) -> [String] {
        return string.split(separator: " ").map(String.init)
    }
}

class BridgeClass {
    let source: SourceProtocol

    init(source: SourceProtocol) {
        self.source = source
    }
    
    func tokens(forTarget target: TargetProtocol) -> [String] {
        return target.tokens(string: source.name())
    }
}
