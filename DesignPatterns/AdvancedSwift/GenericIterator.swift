//
//  GenericIterator.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/17/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol Iterator {
    associatedtype T
    func next() -> T?
}

indirect enum AnyValue<T> {
    case value(value: T)
    case array(array: [AnyValue<T>])
}

class GenericIterator<U> : Iterator {
    typealias T = U

    private var value: AnyValue<U>
    private var index: Int
    private var iteratorsStack: [GenericIterator<U>]
    private var wasCalled: Bool


    init(value: AnyValue<U>) {
        self.value = value
        index = 0
        iteratorsStack = [GenericIterator<U>]()
        wasCalled = false
    }

    func next() -> T? {
        if let it = iteratorsStack.last {
            // If there's an iterator on the stack, then just use that.
            // If the iterator has a next, we return that value, otherwise
            // we remove the iterator and recursively call `self.next()`.
            if let result = it.next() {
                return result
            } else {
                _ = iteratorsStack.popLast()
                return next()
            }
        }

        switch value {
        case .value(let value):
            guard !wasCalled else {
                return nil
            }
            wasCalled = true
            return value
        case .array(let array):
            // The iterators stack is empty and we check whenever we are
            // out of bounds.
            guard
                index >= 0,
                index < array.count
            else {
                return nil
            }

            // Now, we construct the stack of iterators for the element at
            // index `index`
            switch (array[index]) {
            case .value(let value):
                // If it's a concrete type, we just advance the index and
                // return the value.
                index = index + 1
                return value
            case .array(let innerArray):
                // For an array, we create an iterator for that array and
                // we put it on the stack.
                // After we advance the index, we recursively call self.next()
                let currentIterator = GenericIterator(value: .array(array: innerArray))
                iteratorsStack.append(currentIterator)
                index = index + 1
                return next()
            }
        }
    }
}
