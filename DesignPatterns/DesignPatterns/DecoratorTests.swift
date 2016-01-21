//
//  DecoratorTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class DecoratorTests : SampleTest {
    class func runSamples() {
        let simpleCoffee: Coffee = SimpleCoffee()
        print(simpleCoffee.getIngredients())

        let milkCoffee: Coffee = MilkCoffee(decoratedCoffee: simpleCoffee)
        print(milkCoffee.getIngredients())
        
        let icedMocchaCoffee: IcedMocchaCoffee = IcedMocchaCoffee(decoratedCoffee: simpleCoffee)
        print(icedMocchaCoffee.getIngredients())
    }
}