//
//  Decorator.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Attach additional responsibilities to an object dynamically and transparently.
 Decorators provide a flexible alternative to subclassing for extending
 functionality.
 */
protocol Coffee {
    func getIngredients() -> String
}

class SimpleCoffee : Coffee {
    func getIngredients() -> String {
        return "Coffee"
    }
}

class CoffeeDecorator : Coffee {
    private let decoratedCoffee: Coffee
    
    required init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }
    
    func getIngredients() -> String {
        return decoratedCoffee.getIngredients() + (self.getExtraIngredients()?.joinWithSeparator(",") ?? "")
    }
    
    func getExtraIngredients() -> [String]? {
        return nil
    }
}

class MilkCoffee : CoffeeDecorator {
    override func getExtraIngredients() -> [String]? {
        return ["Milk"]
    }
}

class IcedMocchaCoffee : CoffeeDecorator {
    override func getExtraIngredients() -> [String]? {
        return ["Milk", "Ice", "Caramel"]
    }
}
