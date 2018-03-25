//
//  Visitor.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Represent an operation to be performed on the elements of an object structure.
 Visitor lets you define a new operation without changing the classes of the
 elements on which it operates.
 */
protocol Visitor {
    func visit(numberValue number: Int)
    func visit(stringValue string: String)
}

class GenericVisitor<T: Comparable> {
    func visit(key: T) { assert(false) }
}

protocol VisiteableObject {
    func accept(visitor: Visitor)
}

class NumberObject : VisiteableObject {
    var number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(numberValue: number)
    }
}

class StringObject : VisiteableObject {
    var string: String
    
    init(string: String) {
        self.string = string
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(stringValue: string)
    }
}
