//
//  Functions.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 2/24/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import Foundation

// key-path
// autoclosures

class Autoclosures {
    static func and(_ lhs: Bool, _ rhs: @autoclosure () -> Bool) -> Bool {
        guard lhs else {
            return lhs
        }
        return rhs()
    }
}
