//
//  BinarySearchTreeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class IntVisitor : GenericVisitor<Int> {
    override func visit(key: Int) {
        print(key)
    }
}

class BinarySearchTreeTests : SampleTest {
    class func runSamples() {
        let visitor: GenericVisitor<Int> = IntVisitor.init()
        
        let root: BinarySearchTree<Int> = BinarySearchTree.init(initialValue: 1)
        root.insert(5)
        root.insert(3)
        root.insert(2)
        
        assert(root.find(3))
        assert(!root.find(33))
        
        let inorder : InorderTraversal<Int> = InorderTraversal.init(root: root, visitor: visitor)
        print("=== inorder ===")
        inorder.traverse()
        
        root.delete(3)
        print("=== inorder ===")
        inorder.traverse()
        
        let preorder : PreorderTraversal<Int> = PreorderTraversal.init(root: root, visitor: visitor)
        print("=== preorder ===")
        preorder.traverse()
        
        let postorder : PostorderTraversal<Int> = PostorderTraversal.init(root: root, visitor: visitor)
        print("=== postorder ===")
        postorder.traverse()

        let inorderIterative : InorderIterativeTraversal<Int> = InorderIterativeTraversal.init(root: root, visitor: visitor)
        print("=== inorder iterative ===")
        for item in inorderIterative {
            print(item)
        }

        let preorderIterative: PreorderIterativeTraversal<Int> = PreorderIterativeTraversal.init(root: root, visitor: visitor)
        print("=== preorder iterative ===")
        for item in preorderIterative {
            print(item)
        }

        let reversePostOrderIterative: ReversePostorderIterativeTraversal<Int> = ReversePostorderIterativeTraversal.init(root: root, visitor: visitor)
        print("=== reverse postorder iterative ===")
        for item in reversePostOrderIterative {
            print(item)
        }

        let postOrderIterative: PostorderIterativeTraversal<Int> = PostorderIterativeTraversal.init(root: root, visitor: visitor)
        print("=== postorder iterative ===")
        for item in postOrderIterative {
            print(item)
        }
    }
}