//
//  Sorting.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/26/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

typealias SortDescriptor<Value> = (Value, Value) -> Bool

func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key,
    by areIncreasingOrder: @escaping (Key, Key) -> Bool) -> SortDescriptor<Value> {
    return {
        areIncreasingOrder(key($0), key($1))
    }
}

func combine<Value>(
    sortDescriptors: [SortDescriptor<Value>]) -> SortDescriptor<Value> {
    return { (lhs: Value, rhs: Value) -> Bool in
        for sortDescriptor in sortDescriptors {
            if sortDescriptor(lhs, rhs) {
                return true
            } else if sortDescriptor(rhs, lhs) {
                return false
            }
        }
        return false
    }
}
