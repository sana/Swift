//
//  AbstractFactoryTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/21/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class AbstractFactoryTests : SampleTest {
    class func runSamples() {
        let integerFactory = AbstractFactory.factoryFor(NumberType.IntegerNumber)
        print(integerFactory("123.43"))

        let realFactory = AbstractFactory.factoryFor(NumberType.RealNumber)
        print(realFactory("123.43"))
    }
}

