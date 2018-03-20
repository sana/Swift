//
//  Iterator.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Provide a way to access the elements of an aggregate object sequentially
 without exposing its underlying implementation.
 */
class IterableListOfLists<T> : SequenceType
{
    var currentArrayIndex: Int
    var currentItemIndex: Int
    let data: [[T?]]
    typealias Generator = AnyGenerator<T>
    
    init(data: [[T?]]) {
        self.data = data
        self.currentArrayIndex = 0
        self.currentItemIndex = 0
    }
    
    func generate() -> AnyGenerator<T> {
        return anyGenerator {
            repeat {
                if (self.currentArrayIndex >= self.data.count) {
                    return nil
                }
                let currentArray = self.data[self.currentArrayIndex]
                if (self.currentItemIndex >= currentArray.count) {
                    self.currentItemIndex = 0
                    self.currentArrayIndex++
                } else {
                    let currentItem: T? = currentArray[self.currentItemIndex]
                    self.currentItemIndex++
                    if let currentItem = currentItem {
                        return currentItem
                    }
                }
            } while(true)
        }
    }
}

/*
4. Iterator
b) DFS/BFS
c) Inorder/preorder/postorder
d) Level traversal for any tree
*/