//
//  BinarySearchTree.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

func ==<T>(lhs: Tree<T>, rhs: Tree<T>) -> Bool {
    return lhs === rhs
}

class BinarySearchTree<T: Comparable> {
    let tree: Tree<T>
    
    init(initialValue: T) {
        tree = Tree(key: initialValue)
    }

    func value() -> T {
        return tree.key
    }
    
    func treeNode() -> Tree<T> {
        return tree
    }

    func left() -> Tree<T>? {
        return tree.left
    }

    func right() -> Tree<T>? {
        return tree.right
    }
    
    func insert(value: T) -> Bool {
        return insert(value: value, currentNode: self.tree)
    }
    
    func find(value: T) -> Bool {
        return find(value: value, currentNode: self.tree)
    }
    
    func delete(value: T) -> Bool {
        return delete(value: value, previousNode: nil, currentNode: self.tree)
    }
    
    // MARK :- Private methods
    
    private func insert(value: T, currentNode: Tree<T>) -> Bool {
        let insertLeft = currentNode.key > value
        let insertRight = currentNode.key < value
        if (!insertLeft && !insertRight) {
            // value already exists
            return false
        }
        if (currentNode.isLeaf()) {
            if (insertLeft) {
                currentNode.left = Tree(key: value)
            } else {
                currentNode.right = Tree(key: value)
            }
            return true
        } else {
            if (insertLeft) {
                if let left = currentNode.left {
                    return insert(value: value, currentNode: left)
                }
            } else {
                if let right = currentNode.right {
                    return insert(value: value, currentNode: right)
                }
            }
        }
        return false
    }

    private func find(value: T, currentNode: Tree<T>?) -> Bool {
        if let currentNode = currentNode {
            if (value < currentNode.key) {
                return find(value: value, currentNode: currentNode.left)
            } else if (value > currentNode.key) {
                return find(value: value, currentNode: currentNode.right)
            }
            return true
        } else {
            return false
        }
    }
    
    private func delete(value: T, previousNode: Tree<T>?, currentNode: Tree<T>?) -> Bool {
        // `previousNode` is the parent of the `currentNode`
        if let currentNode = currentNode {
            if (currentNode.key == value) {
                let mergeLeft = currentNode.left != nil
                let mergeRight = currentNode.right != nil
                
                if let previousNode = previousNode {
                    if let previousLeft = previousNode.left {
                        if (previousLeft == currentNode) {
                            previousNode.left = mergeLeft ? currentNode.left : (mergeRight ? currentNode.right : nil)
                        }
                    }
                    if let previousRight = previousNode.right {
                        if (previousRight == currentNode) {
                            previousNode.right = mergeLeft ? currentNode.left : (mergeRight ? currentNode.right : nil)
                        }
                    }
                }
                
                if (mergeLeft) {
                    var rightMostNode: Tree<T>? = currentNode.left
                    while (rightMostNode?.right != nil) {
                        rightMostNode = rightMostNode?.right
                    }
                    rightMostNode?.right = currentNode.right
                } else if (mergeRight) {
                    var leftMostNode: Tree<T>? = currentNode.right
                    while (leftMostNode?.left != nil) {
                        leftMostNode = leftMostNode?.left
                    }
                    leftMostNode?.left = currentNode.left
                }
                return true
            } else if (value < currentNode.key) {
                return delete(value: value, previousNode: currentNode, currentNode: currentNode.left)
            } else {
                return delete(value: value, previousNode: currentNode, currentNode: currentNode.right)
            }
        }
        return false
    }
}

class TreeTraversal<T: Comparable> {
    let root: BinarySearchTree<T>
    let visitor: GenericVisitor<T>
    
    init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        self.root = root
        self.visitor = visitor
    }
    
    func traverse() {
        return traverse(tree: root.tree)
    }

    fileprivate func traverse(tree: Tree<T>?) {
        /* Override in the subclass */
    }
}

class InorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }
    
    override func traverse(tree: Tree<T>?) {
        guard let node = tree else {
            return
        }
        traverse(tree: node.left)
        visitor.visit(key: node.key)
        traverse(tree: node.right)
    }
}

class PreorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }
    
    override func traverse(tree: Tree<T>?) {
        guard let node = tree else {
            return
        }
        visitor.visit(key: node.key)
        traverse(tree: node.left)
        traverse(tree: node.right)
    }
}

class PostorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }

    override func traverse(tree: Tree<T>?) {
        guard let node = tree else {
            return
        }
        traverse(tree: node.left)
        traverse(tree: node.right)
        visitor.visit(key: node.key)
    }
}

class InorderIterativeTraversal<T: Comparable>: Sequence, IteratorProtocol {
    let root: BinarySearchTree<T>
    var stack = [Tree<T>]()
    var current: Tree<T>?

    init(root: BinarySearchTree<T>) {
        self.root = root
        self.stack = [Tree<T>]()
        self.current = root.treeNode()
    }
    
    func next() -> T? {
        while let node = current {
            stack.append(node)
            current = node.left
        }

        if
            current == nil,
            !stack.isEmpty,
            let node = stack.popLast()
        {
            current = node.right
            return node.key
        }
        return nil
    }
}

class PreorderIterativeTraversal<T: Comparable>: Sequence, IteratorProtocol {
    let root: BinarySearchTree<T>
    var stack = [Tree<T>]()

    init(root: BinarySearchTree<T>) {
        self.root = root
        self.stack = [Tree<T>]()
        self.stack.append(root.treeNode())
    }
    
    func next() -> T? {
        guard
            !stack.isEmpty,
            let current = stack.popLast()
        else {
            return nil
        }

        if let rightNode = current.right {
            stack.append(rightNode)
        }
        if let leftNode = current.left {
            stack.append(leftNode)
        }

        return current.key
    }
}

/**
 1. Push root to first stack.
 2. Loop while first stack is not empty
 2.1 Pop a node from first stack and push it to second stack
 2.2 Push left and right children of the popped node to first stack
 3. Print contents of second stack
 */
class PostorderIterativeTraversal<T: Comparable>: Sequence, IteratorProtocol {
    let root: BinarySearchTree<T>
    var firstStack: [Tree<T>]
    var secondStack: [Tree<T>]

    init(root: BinarySearchTree<T>) {
        self.root = root
        firstStack = [Tree<T>]()
        secondStack = [Tree<T>]()
        firstStack.append(root.treeNode())
    }
    
    func next() -> T? {
        while !firstStack.isEmpty {
            guard let node = firstStack.popLast() else {
                break
            }
            secondStack.append(node)
            if let leftNode = node.left {
                firstStack.append(leftNode)
            }
            if let rightNode = node.right {
                firstStack.append(rightNode)
            }
        }
        return secondStack.popLast()?.key
    }
}
