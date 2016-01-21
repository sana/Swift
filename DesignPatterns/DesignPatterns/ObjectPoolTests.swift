//
//  ObjectPoolTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation


class ObjectPoolTests : SampleTest {
    class func runSamples() {
        let objectPool: ObjectPool = ObjectPoolImplementation(capacity: 3)

        let object1: Object? = objectPool.acquireObject()
        print(object1)
        
        let object2: Object? = objectPool.acquireObject()
        print(object2)
        
        let object3: Object? = objectPool.acquireObject()
        print(object3)
        
        let object4: Object? = objectPool.acquireObject()
        print(object4) // nil

        print(objectPool.releaseObject(Object(id: "5"))) // false
        if let object3 = object3 {
            print(objectPool.releaseObject(object3)) // true
        }
        
        let object5: Object? = objectPool.acquireObject()
        print(object5)
        
        let object6: Object? = objectPool.acquireObject()
        print(object6) // nil
    }
}