//
//  Composite.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Compose objects into tree structures to represent part-whole hierarchies.
 Composite lets clients treat individual objects and composition of objects
 uniformly.
 */
class Composite<ItemType where ItemType : PrintableClass> : SequenceType, PrintableClass {
    var value: ItemType?

    func add(composite: Composite<ItemType>) -> Bool {
        return false
    }
    
    func remove(composite: Composite<ItemType>) -> Bool {
        return false
    }
    
    func generate() -> AnyGenerator<Composite<ItemType>> {
        return anyGenerator( {
            return nil
        })
    }

    func stringValue() -> String {
        assert(false)
    }
}

class RecursiveComposite<ItemType where ItemType : PrintableClass> : Composite<ItemType> {
    var children: [Composite<ItemType>]

    override init() {
        children = []
    }
    
    override func add(composite: Composite<ItemType>) -> Bool {
        children.append(composite)
        return true
    }

    override func stringValue() -> String {
        return children.map({(let child) -> String in child.stringValue()}).joinWithSeparator(",")
    }
    
    override func generate() -> AnyGenerator<Composite<ItemType>> {
        var currentIndex = -1
        var currentGenerator: AnyGenerator<Composite<ItemType>>?
        return anyGenerator({
            if (currentIndex >= self.children.count) {
                return nil
            }
            let currentItem: Composite<ItemType>? = currentGenerator?.next()
            if (currentItem == nil) {
                currentIndex++
                if (currentIndex < self.children.count) {
                    currentGenerator = self.children[currentIndex].generate()
                }
            } else {
                return currentItem
            }
            return currentGenerator?.next()
        })
    }
}

class LeafComposite<ItemType where ItemType : PrintableClass> : Composite<ItemType> {
    convenience init(value: ItemType) {
        self.init()
        self.value = value
    }
    override func stringValue() -> String {
        if let value = value {
            return value.stringValue()
        }
        return ""
    }
    
    override func generate() -> AnyGenerator<Composite<ItemType>> {
        var wasCalled = false
        return anyGenerator( {
            if (wasCalled) {
                return nil
            }
            wasCalled = true
            return self
        })
    }
}