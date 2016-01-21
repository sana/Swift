//
//  Flyweight.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

let gIngredientsInfo: [String: Int] = [
    "coffee": 10,
    "milk": 100,
    "chocolate": 200,
    "sugar": 50,
    "butter" : 300
]

let gMenuItemsIngredients: [String: [String]] = [
    "plain coffee": ["coffee"],
    "simple coffee": ["coffee", "sugar"],
    "choco coffee": ["coffee", "sugar", "chocolate"],
    "special coffee": ["coffee", "sugar", "chocolate", "sugar", "sugar"],
    "own coffee": ["coffee", "sugar", "chocolate", "sugar", "butter", "sugar", "milk", "milk"],
]

/**
 Use sharing to support large numbers of fine-grained objects efficiently.
 */
class Ingredient : PrintableClass {
    static var cachedIngredients: [String: Ingredient] = [String: Ingredient]()
    private let name: String
    private let calories: Int?
    
    private init(name: String) {
        self.name = name
        self.calories = gIngredientsInfo[name]
    }
    
    class func calories(name: String) -> Int? {
        let ingredient: Ingredient? = Ingredient.cachedIngredients[name]
        if (ingredient == nil) {
            let ingredient: Ingredient = Ingredient.init(name: name)
            Ingredient.cachedIngredients[name] = ingredient
        }
        return Ingredient.cachedIngredients[name]?.calories
    }

    func stringValue() -> String {
        return "\( name ), \( calories )"
    }
}

class MenuItem : PrintableClass {
    static var cachedMenuItems: [String: MenuItem] = [String: MenuItem]()
    private var name: String
    private var calories: Int
    
    private init(name: String) {
        self.name = name
        calories = 0
        calories = _computeCalories()
    }
    
    private func _computeCalories() -> Int {
        var result: Int = 0
        let ingredients: [String]? = gMenuItemsIngredients[name]
        if let ingredients = ingredients {
            for ingredient in ingredients {
                result += Ingredient.calories(ingredient) ?? 0
            }
        }
        return result
    }
    
    class func calories(name: String) -> Int? {
        let menuItem: MenuItem? = MenuItem.cachedMenuItems[name]
        if (menuItem == nil) {
            let menuItem: MenuItem = MenuItem.init(name: name)
            MenuItem.cachedMenuItems[name] = menuItem
        }
        return MenuItem.cachedMenuItems[name]?.calories
    }
    
    func stringValue() -> String {
        return "\( name ), \( calories )"
    }
}

class Order {
    var items: [String]?
    var table: String
    
    init(table: String) {
        self.table = table
    }
    
    func addItem(itemName: String) {
        if (items == nil) {
            items = []
        }
        items?.append(itemName)
    }
    
    func calories() -> Int {
        var result: Int = 0
        if let items = items {
            for menuItem in items {
                result += MenuItem.calories(menuItem) ?? 0
            }
        }
        return result
    }
}