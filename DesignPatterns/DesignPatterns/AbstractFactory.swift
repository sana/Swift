//
//  AbstractFactory.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/21/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

typealias NumberFactory = (String) -> Number

/**
 Intent: provide an interface for creating families of related or dependent
 objects without specifying their concrete classes.
 */
class AbstractFactory {
    class func factoryFor(numberType: NumberType) -> NumberFactory {
        switch (numberType) {
        case .RealNumber:
            return RealNumber.make
        case .IntegerNumber:
            return IntegerNumber.make
        }
    }
}