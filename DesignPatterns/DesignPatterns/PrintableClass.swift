//
//  PrintableClass.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol PrintableClass : CustomStringConvertible {
    func stringValue() -> String
}

extension PrintableClass {
    var description: String {
        return stringValue()
    }
}
