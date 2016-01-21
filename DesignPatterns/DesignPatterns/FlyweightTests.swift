//
//  FlyweightTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class FlyweightTests : SampleTest {
    class func runSamples() {
        let order1: Order = Order(table: "table1")
        order1.addItem("plain coffee")
        order1.addItem("plain coffee")
        order1.addItem("plain coffee")
        print("Order 1: [\((order1.calories()))]")

        let order2: Order = Order(table: "table2")
        order2.addItem("simple coffee")
        order2.addItem("plain coffee")
        order2.addItem("choco coffee")
        print("Order 2: [\((order2.calories()))]")

        let order3: Order = Order(table: "table3")
        order3.addItem("own coffee")
        order3.addItem("choco coffee")
        print("Order 3: [\((order3.calories()))]")

        print(Ingredient.cachedIngredients)
        print(MenuItem.cachedMenuItems)
    }
}