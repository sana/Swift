//
//  CompositeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class CompositeTests : SampleTest {
    class func runSamples() {
        let root: Composite<IntegerNumber> = RecursiveComposite<IntegerNumber>()
        root.add(LeafComposite(value: IntegerNumber.init(integerNumber: 1)))
        root.add(LeafComposite(value: IntegerNumber.init(integerNumber: 2)))
        let recursiveComposite = RecursiveComposite<IntegerNumber>()
        recursiveComposite.add(LeafComposite(value: IntegerNumber.init(integerNumber: 4)))
        recursiveComposite.add(LeafComposite(value: IntegerNumber.init(integerNumber: 5)))
        root.add(recursiveComposite)
        root.add(LeafComposite(value: IntegerNumber.init(integerNumber: 3)))
        print(root)
        
        // Iterate over a composite type
        for item in root {
            print(item)
        }
    }
}
