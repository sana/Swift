//
//  Builder.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/21/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
  Intent: separate the construction of a complex object from its representation
  so that the same construction can create different representation.
 */

class NumbersSequenceBuilder {
    class func random(numbers: [String], forFactory: NumberFactory) -> [String] {
        return numbers.map { "\( forFactory($0).doubleValue() )" }
    }
}
