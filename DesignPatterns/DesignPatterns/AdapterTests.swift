//
//  AdapterTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class AdapterTests : SampleTest {
    class func runSamples() {
        let stack: ArrayStack = ArrayStack<Int>()
        for i in 1..<5 {
            stack.push(i)
        }
        while (!stack.isEmpty()) {
            print (stack.pop())
        }
    }
}
