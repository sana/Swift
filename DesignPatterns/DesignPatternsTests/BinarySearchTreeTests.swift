//
//  BinarySearchTreeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class IntVisitor : GenericVisitor<Int> {
    public var keys = [Int]()

    override func visit(key: Int) {
        keys.append(key)
    }
}

class BinarySearchTreeTests : XCTestCase {

    private func createBST() -> BinarySearchTree<Int> {
        let root: BinarySearchTree<Int> = BinarySearchTree(initialValue: 1)
        XCTAssert(root.insert(value: 5))
        XCTAssert(root.insert(value: 3))
        XCTAssert(root.insert(value: 2))
        return root
    }

    func testBSTOperations() {
        let root = createBST()
        XCTAssert(root.find(value: 3))
        XCTAssertFalse(root.find(value: 33))

        XCTAssert(root.delete(value: 3))
        XCTAssertFalse(root.find(value: 3))
    }

    func testBSTInorderTraversal() {
        let visitor: IntVisitor = IntVisitor()
        let root = createBST()
        let inorder : InorderTraversal<Int> = InorderTraversal(root: root, visitor: visitor)
        inorder.traverse()
        XCTAssertEqual(visitor.keys, [1, 2, 3, 5])

        XCTAssert(root.delete(value: 3))

        let visitorAfterDelete: IntVisitor = IntVisitor()
        let inorderAfterDelete : InorderTraversal<Int> = InorderTraversal(root: root, visitor: visitorAfterDelete)
        inorderAfterDelete.traverse()

        XCTAssertEqual(visitorAfterDelete.keys, [1, 2, 5])

        XCTAssert(root.insert(value: 4))

        let visitorAfterInsert: IntVisitor = IntVisitor()
        let inorderAfterInsert : InorderTraversal<Int> = InorderTraversal(root: root, visitor: visitorAfterInsert)
        inorderAfterInsert.traverse()

        XCTAssertEqual(visitorAfterInsert.keys, [1, 2, 4, 5])
    }

    func testBSTPreorderTraversal() {
        let visitor: IntVisitor = IntVisitor()
        let root = createBST()
        let preorder : PreorderTraversal<Int> = PreorderTraversal(root: root, visitor: visitor)
        preorder.traverse()
        XCTAssertEqual(visitor.keys, [1, 5, 3, 2])
    }

    func testBSTPostorderTraversal() {
        let visitor: IntVisitor = IntVisitor()
        let root = createBST()
        let postorder : PostorderTraversal<Int> = PostorderTraversal(root: root, visitor: visitor)
        postorder.traverse()
        XCTAssertEqual(visitor.keys, [2, 3, 5, 1])
    }

    func testBSTInorderIterativeTraversal() {
        let root = createBST()
        let inorder : InorderIterativeTraversal<Int> = InorderIterativeTraversal(root: root)
        XCTAssertEqual(Array(inorder), [1, 2, 3, 5])
    }

    func testBSTPreorderIterativeTraversal() {
        let root = createBST()
        let preorder : PreorderIterativeTraversal<Int> = PreorderIterativeTraversal(root: root)
        XCTAssertEqual(Array(preorder), [1, 5, 3, 2])
    }

    func testBSTPostorderIterativeTraversal() {
        let root = createBST()
        let postorder : PostorderIterativeTraversal<Int> = PostorderIterativeTraversal(root: root)
        XCTAssertEqual(Array(postorder), [2, 3, 5, 1])
    }
}
