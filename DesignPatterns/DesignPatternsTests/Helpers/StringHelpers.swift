//
//  StringHelpers.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int = 16) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var result: String = ""
        for _ in 1...length {
            let randomValue: Int = Int(arc4random_uniform(UInt32(base.count)))
            result += "\(base[base.index(base.startIndex, offsetBy: randomValue)])"
        }
        return result
    }
}
