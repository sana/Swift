//
//  Composite.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Intent: Compose objects into tree structures to represent part-whole hierarchies.
 Composite lets clients treat individual objects and composition of objects
 uniformly.
 */

class Composite<ItemType> : CustomStringConvertible, Sequence where ItemType : CustomStringConvertible {
    typealias Iterator = AnyIterator<Composite<ItemType>>

    public let value: ItemType?

    init(value: ItemType?) {
        self.value = value
    }

    var description: String {
        guard let value = value else {
            fatalError("override in subclasses, if there is no value")
        }
        return value.description
    }

    func add(composite: Composite<ItemType>) -> Bool {
        return false
    }
    
    func remove(composite: Composite<ItemType>) -> Bool {
        return false
    }
    
    func makeIterator() -> Iterator {
        return AnyIterator( {
            return nil
        })
    }
}

class LeafComposite<ItemType> : Composite<ItemType> where ItemType : CustomStringConvertible {
    override func makeIterator() -> Iterator {
        var wasCalled = false
        return AnyIterator( {
            if (wasCalled) {
                return nil
            }
            wasCalled = true
            return self
        })
    }
}

class RecursiveComposite<ItemType> : Composite<ItemType> where ItemType : CustomStringConvertible {
    private var children: [Composite<ItemType>]

    init() {
        self.children = []
        super.init(value: nil)
    }

    override func add(composite: Composite<ItemType>) -> Bool {
        children.append(composite)
        return true
    }

    override var description: String {
        return children.map { $0.description }.joined(separator: ",")
    }
    
    override func makeIterator() -> Iterator {
        var currentIndex = -1
        var currentGenerator: Iterator?
        return AnyIterator({
            if (currentIndex >= self.children.count) {
                return nil
            }
            let currentItem: Composite<ItemType>? = currentGenerator?.next()
            if (currentItem == nil) {
                currentIndex = currentIndex + 1
                if (currentIndex < self.children.count) {
                    currentGenerator = self.children[currentIndex].makeIterator()
                }
            } else {
                return currentItem
            }
            return currentGenerator?.next()
        })
    }
}
