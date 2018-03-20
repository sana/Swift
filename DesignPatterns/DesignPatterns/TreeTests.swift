//
//  TreeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class TreeTests : SampleTest {
    class func runSamples() {
        let root : Tree<Int> = Tree.init(
            key: 1,
            left: Tree.init(key: 2,
                left: Tree.init(key: 4),
                right: Tree.init(key: 5)),
            right: Tree.init(key: 3))
        let dfsIterator: DFSIterator = DFSIterator.init(root: root)
        for item in dfsIterator {
            print(item)
        }
        
        let bfsIterator: BFSIterator = BFSIterator.init(root: root)
        for item in bfsIterator {
            print(item)
        }
    }
}