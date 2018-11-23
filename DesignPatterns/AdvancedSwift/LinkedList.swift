//
//  LinkedList.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/22/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

enum LinkedList<Element> {
    case end
    indirect case node(value: Element, next: LinkedList<Element>)
}

extension LinkedList {
    func cons(_ value: Element) -> LinkedList {
        return .node(value: value, next: self)
    }
}

extension LinkedList {
    func asArray() -> [Element] {
        var result = [Element]()
        var it = self
        repeat {
            switch it {
            case .end:
                return result
            case let .node(value, next):
                result.append(value)
                it = next
            }
        } while true
    }
}

extension LinkedList : ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Element

    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end, { (list, value) -> LinkedList in
            return list.cons(value)
        })
    }
}

extension LinkedList {
    mutating func push(_ element: Element) {
        self = cons(element)
    }

    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(value, next):
            self = next
            return value
        }
    }
}

extension LinkedList : IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return self.pop()
    }
}
