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
    var tree: Tree<T>
    
    init(initialValue: T) {
        tree = Tree.init(key: initialValue)
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
        return _insert(value, currentNode: self.tree)
    }
    
    func find(value: T) -> Bool {
        return _find(value, currentNode: self.tree)
    }
    
    func delete(value: T) -> Bool {
        return _delete(value, previousNode: nil, currentNode: self.tree)
    }
    
    // Private methods
    
    func _insert(value: T, currentNode: Tree<T>) -> Bool {
        let insertLeft = currentNode.key > value
        let insertRight = currentNode.key < value
        if (!insertLeft && !insertRight) {
            // value already exists
            return false
        }
        if (currentNode.isLeaf()) {
            if (insertLeft) {
                currentNode.left = Tree.init(key: value)
            } else {
                currentNode.right = Tree.init(key: value)
            }
            return true
        } else {
            if (insertLeft) {
                if let left = currentNode.left {
                    return _insert(value, currentNode: left);
                }
            } else {
                if let right = currentNode.right {
                    return _insert(value, currentNode: right);
                }
            }
        }
        return false
    }

    func _find(value: T, currentNode: Tree<T>?) -> Bool {
        if let currentNode = currentNode {
            if (value < currentNode.key) {
                return _find(value, currentNode: currentNode.left)
            } else if (value > currentNode.key) {
                return _find(value, currentNode: currentNode.right)
            }
            return true
        } else {
            return false
        }
    }
    
    func _delete(value: T, previousNode: Tree<T>?, currentNode: Tree<T>?) -> Bool {
        // previousNode is parent of the currentNode
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
                return _delete(value, previousNode: currentNode, currentNode: currentNode.left)
            } else {
                return _delete(value, previousNode: currentNode, currentNode: currentNode.right)
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
        return _traverse(root.tree)
    }

    func _traverse(tree: Tree<T>?) {
        assert(false)
    }
}

class InorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }
    
    override func _traverse(tree: Tree<T>?) {
        if let tree = tree {
            _traverse(tree.left)
            print(tree.key)
            _traverse(tree.right)
        }
    }
}

class PreorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }
    
    override func _traverse(tree: Tree<T>?) {
        if let tree = tree {
            print(tree.key)
            _traverse(tree.left)
            _traverse(tree.right)
        }
    }
}

class PostorderTraversal<T: Comparable>: TreeTraversal<T> {
    override init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        super.init(root: root, visitor: visitor)
    }

    override func _traverse(tree: Tree<T>?) {
        if let tree = tree {
            _traverse(tree.left)
            _traverse(tree.right)
            visitor.visit(tree.key)
        }
    }
}

class InorderIterativeTraversal<T: Comparable>: SequenceType {
    let root: BinarySearchTree<T>
    let visitor: GenericVisitor<T>
    var stack = [Tree<T>]()
    var current: Tree<T>?

    init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        self.root = root
        self.visitor = visitor
    }
    
    func generate() -> AnyGenerator<T> {
        stack = [Tree<T>]()
        current = root.treeNode()
        return anyGenerator {
            while (self.current != nil) {
                self.stack.append(self.current!)
                self.current = self.current?.left
            }

            if (self.current == nil && !self.stack.isEmpty) {
                let node = self.stack.popLast()
                self.current = node?.right
                return node?.key
            }
            return nil
        }
    }
}

class PreorderIterativeTraversal<T: Comparable>: SequenceType {
    let root: BinarySearchTree<T>
    let visitor: GenericVisitor<T>
    var stack = [Tree<T>]()

    init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        self.root = root
        self.visitor = visitor
    }
    
    func generate() -> AnyGenerator<T> {
        stack = [Tree<T>]()
        stack.append(root.treeNode())
        return anyGenerator {
            if (self.stack.isEmpty) {
                return nil
            }
            
            let current = self.stack.popLast()
            if let rightNode = current?.right {
                self.stack.append(rightNode)
            }
            if let leftNode = current?.left {
                self.stack.append(leftNode)
            }
            return current?.key
        }
    }
}

class ReversePostorderIterativeTraversal<T: Comparable>: SequenceType {
    let root: BinarySearchTree<T>
    let visitor: GenericVisitor<T>
    var stack = [Tree<T>]()
    
    init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        self.root = root
        self.visitor = visitor
    }
    
    func generate() -> AnyGenerator<T> {
        stack = [Tree<T>]()
        stack.append(root.treeNode())
        return anyGenerator {
            if let lastNode = self.stack.popLast() {
                if let leftNode = lastNode.left {
                    self.stack.append(leftNode)
                }
                if let rightNode = lastNode.right {
                    self.stack.append(rightNode)
                }
                return lastNode.key
            }
            return nil
        }
    }
}

/**
 1.1 Create an empty stack
 2.1 Do following while root is not NULL
    a) Push root's right child and then root to stack.
    b) Set root as root's left child.
 2.2 Pop an item from stack and set it as root.
    a) If the popped item has a right child and the right child
    is at top of stack, then remove the right child from stack,
    push the root back and set root as root's right child.
    b) Else print root's data and set root as NULL.
 2.3 Repeat steps 2.1 and 2.2 while stack is not empty.
 */
class PostorderIterativeTraversal<T: Comparable>: SequenceType {
    let root: BinarySearchTree<T>
    let visitor: GenericVisitor<T>
    var stack = [Tree<T>]()
    var rootNode: Tree<T>?
    
    init(root: BinarySearchTree<T>, visitor: GenericVisitor<T>) {
        self.root = root
        self.visitor = visitor
    }
    
    func generate() -> AnyGenerator<T> {
        stack = [Tree<T>]()
        rootNode = root.treeNode()
        return anyGenerator {
            while self.rootNode != nil {
                if let rightNode = self.rootNode!.right {
                    self.stack.append(rightNode)
                }
                self.stack.append(self.rootNode!)
                self.rootNode = self.rootNode?.left
            }
            if (!self.stack.isEmpty) {
                self.rootNode = self.stack.popLast()
                if let rightNode = self.rootNode!.right {
                    if (!self.stack.isEmpty && self.stack.last! == rightNode) {
                        self.stack.popLast()
                        self.stack.append(self.rootNode!)
                        self.rootNode = self.rootNode?.right
                    } else {
                        if let node = self.rootNode {
                            return node.key
                        }
                        self.rootNode = nil
                    }
                } else {
                    if let node = self.rootNode {
                        return node.key
                    }
                    self.rootNode = nil
                }
            }

            return nil
        }
    }
}
