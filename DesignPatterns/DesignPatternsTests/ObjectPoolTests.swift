//
//  ObjectPoolTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 6/24/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class ObjectPoolTests : XCTestCase {
    func testObjectPoolImplementation() {
        let objectPool: ObjectPool = ObjectPoolImplementation(capacity: 3)

        let object1 = objectPool.acquireObject()
        XCTAssertNotNil(object1)

        let object2 = objectPool.acquireObject()
        XCTAssertNotNil(object2)

        let object3 = objectPool.acquireObject()
        XCTAssertNotNil(object3)

        let object4: Object? = objectPool.acquireObject()
        XCTAssertNil(object4)

        XCTAssertFalse(objectPool.releaseObject(object: Object(id: "5")))
        guard let poolObject3 = object3 else {
            XCTFail("Pool object3 is nil")
            return
        }
        XCTAssert(objectPool.releaseObject(object: poolObject3))

        let object5 = objectPool.acquireObject()
        XCTAssertNotNil(object5)

        let object6 = objectPool.acquireObject()
        XCTAssertNil(object6)
    }
}
