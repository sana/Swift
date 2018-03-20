//
//  Tree.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class Tree<T> {
    var key: T
    var left: Tree<T>?
    var right: Tree<T>?
    
    init(key: T, left: Tree<T>?, right: Tree<T>?) {
        self.key = key
        self.left = left
        self.right = right
    }
    
    convenience init(key: T) {
        self.init(key: key, left: nil, right: nil)
    }
    
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
}

// Breadth-first search iterator for a binary tree, which is equivalent to a
// level order traversal
class BFSIterator<T> : SequenceType {
    var root: Tree<T>
    var queue: [Tree<T>]?

    init(root: Tree<T>) {
        self.root = root
    }
    
    func generate() -> AnyGenerator<T> {
        self.queue = [root]
        return anyGenerator {
            if (self.queue?.isEmpty ?? true) {
                return nil
            }
            if let currentNode = self.queue?.removeFirst() {
                let result: Tree<T> = currentNode
                if let left = currentNode.left {
                    self.queue?.append(left)
                }
                if let right = currentNode.right {
                    self.queue?.append(right)
                }
                return result.key
            }
            return nil
        }
    }
}

// Depth-first search iterator
class DFSIterator<T> : SequenceType {
    var root: Tree<T>
    var stack: [Tree<T>]?

    init(root: Tree<T>) {
        self.root = root
    }

    func generate() -> AnyGenerator<T> {
        self.stack = [root]
        return anyGenerator {
            if (self.stack?.isEmpty ?? true) {
                return nil
            }
            if let currentNode = self.stack?.removeLast() {
                let result: Tree<T> = currentNode
                if let right = currentNode.right {
                    self.stack?.append(right)
                }
                if let left = currentNode.left {
                    self.stack?.append(left)
                }
                return result.key
            }
            return nil
        }
    }
}
