//
//  Strategy.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Define a family of algorithms, encapsulate each one, and make them
 interchangeable. Strategy lets the algorithm vary independently from clients
 that use it.
 */
protocol PrintStrategy {
    func transform(string: String) -> String
}

class LowercasePrintStrategy : PrintStrategy {
    func transform(string: String) -> String {
        return string.lowercased()
    }
}

class UppercasePrintStrategy : PrintStrategy {
    func transform(string: String) -> String {
        return string.uppercased()
    }
}

struct Printer {
    let printStrategy: PrintStrategy
    
    func prepareForPrinting(string: String) -> String {
        return printStrategy.transform(string: string)
    }
}
