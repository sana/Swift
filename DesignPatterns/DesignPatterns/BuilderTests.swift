//
//  BuilderTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/21/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class BuilderTests : SampleTest {
    class func runSamples() {
        let integerFactory = AbstractFactory.factoryFor(NumberType.IntegerNumber)
        print(NumbersSequenceBuilder.randomNumbers(integerFactory))

        let realFactory = AbstractFactory.factoryFor(NumberType.RealNumber)
        print(NumbersSequenceBuilder.randomNumbers(realFactory))
    }
}
