//
//  Flyweight.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

let globalIngredientsInfo: [String: Int] = [
    "coffee": 10,
    "milk": 100,
    "chocolate": 200,
    "sugar": 50,
    "butter" : 300
]

let globalMenuItemsIngredients: [String: [String]] = [
    "plain coffee": ["coffee"],
    "simple coffee": ["coffee", "sugar"],
    "choco coffee": ["coffee", "sugar", "chocolate"],
    "special coffee": ["coffee", "sugar", "chocolate", "sugar", "sugar"],
    "own coffee": ["coffee", "sugar", "chocolate", "sugar", "butter", "sugar", "milk", "milk"],
]

/**
 Use sharing to support large numbers of fine-grained objects efficiently.
 */
class Ingredient {
    static var cachedIngredients: [String: Ingredient] = [String: Ingredient]()
    private let name: String
    private let calories: Int?
    
    private init(name: String) {
        self.name = name
        self.calories = globalIngredientsInfo[name]
    }
    
    static func calories(forIngredientName name: String) -> Int? {
        let ingredient: Ingredient? = Ingredient.cachedIngredients[name]
        if (ingredient == nil) {
            let ingredient: Ingredient = Ingredient(name: name)
            Ingredient.cachedIngredients[name] = ingredient
        }
        return Ingredient.cachedIngredients[name]?.calories
    }
}

class MenuItem {
    static var cachedMenuItems: [String: MenuItem] = [String: MenuItem]()
    private var name: String
    private var calories: Int
    
    private init(name: String) {
        self.name = name
        self.calories = MenuItem.computeCalories(forMenuItemName: name)
    }
    
    private static func computeCalories(forMenuItemName name: String) -> Int {
        var result: Int = 0
        let ingredients: [String]? = globalMenuItemsIngredients[name]
        if let ingredients = ingredients {
            for ingredient in ingredients {
                result += Ingredient.calories(forIngredientName: ingredient) ?? 0
            }
        }
        return result
    }
    
    static func calories(forMenuItemName name: String) -> Int? {
        let menuItem: MenuItem? = MenuItem.cachedMenuItems[name]
        if (menuItem == nil) {
            let menuItem: MenuItem = MenuItem(name: name)
            MenuItem.cachedMenuItems[name] = menuItem
        }
        return MenuItem.cachedMenuItems[name]?.calories
    }
}

class Order {
    private var items: [String]
    private let table: String
    
    init(table: String) {
        self.items = []
        self.table = table
    }
    
    func addItem(itemName: String) {
        items.append(itemName)
    }
    
    func calories() -> Int {
        return items.compactMap { MenuItem.calories(forMenuItemName: $0) }.reduce(0, +)
    }
}
