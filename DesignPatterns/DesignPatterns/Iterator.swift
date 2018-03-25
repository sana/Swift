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

class IterableListOfLists<T> : Sequence, IteratorProtocol
{
    var currentArrayIndex: Int
    var currentItemIndex: Int
    let data: [[T?]]

    init(data: [[T?]]) {
        self.data = data
        self.currentArrayIndex = 0
        self.currentItemIndex = 0
    }
    
    func next() -> T? {
        repeat {
            if (currentArrayIndex >= data.count) {
                return nil
            }
            let currentArray = data[currentArrayIndex]
            if (currentItemIndex >= currentArray.count) {
                currentItemIndex = 0
                currentArrayIndex = currentArrayIndex + 1
            } else {
                let currentItem: T? = currentArray[currentItemIndex]
                currentItemIndex = currentItemIndex + 1
                if let currentItem = currentItem {
                    return currentItem
                }
            }
        } while(true)
    }
}
