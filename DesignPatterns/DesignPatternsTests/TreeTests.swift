//
//  TreeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class TreeTests : XCTestCase {
    private func createTree() -> Tree<Int> {
        let root : Tree<Int> = Tree(
            key: 1,
            left: Tree(key: 2,
                            left: Tree(key: 4),
                            right: Tree(key: 5)),
            right: Tree(key: 3))
        return root
    }

    func testBFSIterator() {
        let root = createTree()
        let bfsIterator: BFSIterator = BFSIterator(root: root)
        let expectedArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(Array(bfsIterator), expectedArray)
    }

    func testDFSIterator() {
        let root = createTree()
        let bfsIterator: DFSIterator = DFSIterator(root: root)
        let expectedArray = [1, 2, 4, 5, 3]
        XCTAssertEqual(Array(bfsIterator), expectedArray)
    }

    func testLevelOrderIterator() {
        let root = createTree()
        let levelOrderIterator: LevelOrderIterator = LevelOrderIterator(root: root)
        let expectedArray = [1, 2, 3, 4, 5]
        XCTAssertEqual(Array(levelOrderIterator), expectedArray)
    }
}
