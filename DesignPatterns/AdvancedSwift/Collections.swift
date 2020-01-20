//
//  Collections.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 11/22/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/*
 A `collection` is a stable `sequence` that can be traversed nondestructively
 multiple times. Its elements can be accessed with an index, i.e. subscription
 is supported.

 Unlike sequences, collections can't be infinite.
 */

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    private var left = [Element]()
    private var right = [Element]()

    mutating func enqueue(_ newElement: Element) {
        left.append(newElement)
    }

    mutating func dequeue() -> Element? {
        if right.isEmpty {
            right = left.reversed()
            left = [Element]()
        }
        return right.popLast()
    }
}

extension FIFOQueue : Collection {
    typealias Index = Int

    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }

    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }

    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position))
        if position < left.endIndex {
            return left[left.count - position - 1]
        }
        return right[position - left.endIndex]
    }
}

extension Substring {
    var nextWordRange: Range<Index> {
        let start = drop(while: { $0 == " "})
        let end = start.firstIndex(where: { $0 == " " }) ?? endIndex
        return start.startIndex..<end
    }
}

struct Words : Collection {
    typealias Index = WordsIndex

    let string: Substring
    let startIndex: Words.Index

    init(_ s: String) {
        self.init(s[...])
    }

    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }

    var endIndex: Words.Index {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }

    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }

    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else {
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

struct WordsIndex : Comparable {
    fileprivate let range: Range<Substring.Index>

    fileprivate init(_ range: Range<Substring.Index>) {
        self.range = range
    }

    static func <(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }

    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}
