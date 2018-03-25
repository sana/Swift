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
class BFSIterator<T> : Sequence, IteratorProtocol {
    let root: Tree<T>
    var queue: [Tree<T>]

    init(root: Tree<T>) {
        self.root = root
        self.queue = [root]
    }
    
    func next() -> T? {
        guard !queue.isEmpty else {
            return nil
        }
        let currentNode = queue.removeFirst()
        let result: Tree<T> = currentNode
        if let left = currentNode.left {
            queue.append(left)
        }
        if let right = currentNode.right {
            queue.append(right)
        }
        return result.key
    }
}

// Depth-first search iterator
class DFSIterator<T> : Sequence, IteratorProtocol {
    let root: Tree<T>
    var stack: [Tree<T>]

    init(root: Tree<T>) {
        self.root = root
        self.stack = [root]
    }

    func next() -> T? {
        guard !self.stack.isEmpty else {
            return nil
        }
        let currentNode = stack.removeLast()
        let result: Tree<T> = currentNode
        if let right = currentNode.right {
            stack.append(right)
        }
        if let left = currentNode.left {
            stack.append(left)
        }
        return result.key
    }
}

// Level order traversal using a queue
class LevelOrderIterator<T> : Sequence, IteratorProtocol {
    let root: Tree<T>
    var queue: [Tree<T>]

    init(root: Tree<T>) {
        self.root = root
        self.queue = [root]
    }

    func next() -> T? {
        guard !queue.isEmpty else {
            return nil
        }
        let node = queue.removeFirst()
        if let leftNode = node.left {
            queue.append(leftNode)
        }
        if let rightNode = node.right {
            queue.append(rightNode)
        }
        return node.key
    }
}
