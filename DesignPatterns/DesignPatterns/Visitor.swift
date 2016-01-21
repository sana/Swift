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
    func visit(number: Int)
    func visit(string: String)
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
        visitor.visit(number)
    }
}

class StringObject : VisiteableObject {
    var string: String
    
    init(string: String) {
        self.string = string
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(string)
    }
}

class VisitorCenter {
    private let objects: [VisiteableObject] = [
        NumberObject(number: 1),
        StringObject(string: "2"),
        NumberObject(number: 3),
        StringObject(string: "4"),
        NumberObject(number: 5),
    ]
    
    func visitObjects(visitor: Visitor) {
        for object in objects {
            object.accept(visitor)
        }
    }
}