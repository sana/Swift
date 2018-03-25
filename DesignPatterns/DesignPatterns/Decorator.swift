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
    func ingredients() -> [String]
}

class SimpleCoffee : Coffee {
    func ingredients() -> [String] {
        return ["coffee"]
    }
}

class CoffeeDecorator : Coffee {
    private let decoratedCoffee: Coffee
    
    required init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }
    
    func ingredients() -> [String] {
        return decoratedCoffee.ingredients() + self.extraIngredients()
    }
    
    func extraIngredients() -> [String] {
        return []
    }
}

class MilkCoffee : CoffeeDecorator {
    override func extraIngredients() -> [String] {
        return ["milk"]
    }
}

class IcedMocchaCoffee : CoffeeDecorator {
    override func extraIngredients() -> [String] {
        return ["milk", "ice", "caramel"]
    }
}
