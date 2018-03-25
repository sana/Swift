//
//  Number.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

enum NumberType {
    case RealNumber
    case IntegerNumber
}

protocol Number {
    static func make(string: String) -> Number
    func doubleValue() -> Double
}

class RealNumber : Number {
    private let realNumber : NSNumber
    
    init(realNumber: NSNumber) {
        self.realNumber = realNumber
    }

    class func make(string: String) -> Number {
        return RealNumber(realNumber: NSNumber(value: (string as NSString).doubleValue))
    }

    func doubleValue() -> Double {
        return realNumber.doubleValue
    }
}

class IntegerNumber : Number {
    private let integerNumber : Int
    
    init(integerNumber: Int) {
        self.integerNumber = integerNumber
    }

    class func make(string: String) -> Number {
        return IntegerNumber(integerNumber: (string as NSString).integerValue)
    }

    func doubleValue() -> Double {
        return Double(integerNumber)
    }
}

// MARK :- CustomStringConvertible

extension RealNumber : CustomStringConvertible {
    var description: String {
        return "\( realNumber )"
    }
}

extension IntegerNumber : CustomStringConvertible {
    var description: String {
        return "\( integerNumber )"
    }
}
