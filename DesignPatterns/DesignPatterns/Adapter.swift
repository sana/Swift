//
//  Adapter.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Convert the interface of a class into another interface clients expect.
 Adapter lets classes work together that couldn't otherwise because of
 incompatible interfaces.
 */
protocol Stack {
    typealias ItemType
    func push(key: ItemType)
    func pop() -> ItemType
    func isEmpty() -> Bool
}

class ArrayStack<T> : NSArray, Stack {
    typealias ItemType = T
    var items = [T]()
    
    override init() {
        super.init()
    }
    
    func push(key: T) {
        items.append(key)
    }

    func pop() -> T {
        return items.removeLast()
    }
    
    func isEmpty() -> Bool {
        return items.count <= 0
    }
}