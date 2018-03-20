//
//  IteratorTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 1/22/16.
//  Copyright © 2016 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class IteratorTests : SampleTest {
    class func runSamples() {
        let list1: IterableListOfLists = IterableListOfLists.init(data: [[1, 2, 3, 4, 5]])
        for item in list1 {
            print(item)
        }
        
        let list2: IterableListOfLists = IterableListOfLists.init(data: [[1, 2, 3], [4, 5]])
        for item in list2 {
            print(item)
        }

        let list3: IterableListOfLists = IterableListOfLists.init(data: [[1, 2, 3], [nil], [4], [], [5]])
        for item in list3 {
            print(item)
        }

        let list4: IterableListOfLists = IterableListOfLists.init(data: [[nil], [nil, nil, 100], [nil]])
        for item in list4 {
            print(item)
        }
    }
}