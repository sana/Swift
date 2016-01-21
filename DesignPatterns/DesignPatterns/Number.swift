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

protocol Number : PrintableClass {
    static func make(string: String) -> Number
}

class RealNumber : Number {
    private var realNumber : NSNumber
    
    init(realNumber: NSNumber) {
        self.realNumber = realNumber
    }
    
    func stringValue() -> String {
        return realNumber.description
    }
    
    class func make(string: String) -> Number {
        return RealNumber(realNumber: NSNumber(double: (string as NSString).doubleValue))
    }
}

class IntegerNumber : Number {
    private var integerNumber : Int
    
    init(integerNumber: Int) {
        self.integerNumber = integerNumber
    }
    
    func stringValue() -> String {
        return integerNumber.description
    }
    
    class func make(string: String) -> Number {
        return IntegerNumber(integerNumber: (string as NSString).integerValue)
    }
}
