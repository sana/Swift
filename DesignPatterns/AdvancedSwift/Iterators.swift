//
//  Iterators.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/22/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct ConstantIterator : IteratorProtocol {
    typealias Element = Int

    mutating func next() -> Int? {
        return 1
    }
}

struct FibonacciIterator : IteratorProtocol {
    typealias Element = Int
    var state = (1, 1)

    mutating func next() -> Int? {
        let result = state.0
        state = (state.1, state.0 + state.1)
        return result
    }
}

struct PrefixIterator : IteratorProtocol {
    typealias Element = String
    let string: String
    var index: String.Index

    init(string: String) {
        self.string = string
        index = self.string.startIndex
    }

    mutating func next() -> String? {
        guard index < string.endIndex else {
            return nil
        }
        index = string.index(after: index)
        return String(string[..<index])
    }
}

struct PrefixSequence : Sequence {
    typealias Iterator = PrefixIterator
    let string: String

    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}
