//
//  Bridge.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Decouple an abstraction from its implementation so that the two can vary
 independently.
 */
protocol SourceProtocol {
    func name() -> String
}

protocol TargetProtocol {
    func tokens(string: String) -> [String]
}

class SourceClass : SourceProtocol {
    func name() -> String {
        return "I want to break free!"
    }
}

class TargetClass : TargetProtocol {
    func tokens(string: String) -> [String] {
        return string.componentsSeparatedByString(" ")
    }
}

class BridgeClass {
    var source: SourceProtocol
    var target: TargetProtocol?
    
    init(source: SourceProtocol) {
        self.source = source
    }
    
    func printTokens() {
        if let target = target {
            for token in target.tokens(source.name()) {
                print(token)
            }
        }
    }
}