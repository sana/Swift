//
//  PrototypeTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class PrototypeTests : XCTestCase {
    func testInvalidPrototypeName() {
        XCTAssertNil(PrototypeFactory.createNewObject(className: "foo"))
    }

    func testRoomPrototype() {
        guard let roomPrototype = PrototypeFactory.createNewObject(className: "Room") else {
            XCTFail("PrototypeFactory could not create a new object of type `Room`")
            return
        }
        XCTAssertEqual(roomPrototype.description, "Room-default-room-name")
    }

    func testDoorPrototype() {
        guard let doorPrototype = PrototypeFactory.createNewObject(className: "Door") else {
            XCTFail("PrototypeFactory could not create a new object of type `Door`")
            return
        }
        XCTAssertEqual(doorPrototype.description, "Door [Room-default-first-room-name, Room-default-first-room-name]")
    }

    func testPrototypeMethodClosesObjects() {
        guard let firstRoomPrototype = PrototypeFactory.createNewObject(className: "Room") else {
            XCTFail("PrototypeFactory could not create a new object of type `Room`")
            return
        }
        guard let secondRoomPrototype = PrototypeFactory.createNewObject(className: "Room") else {
            XCTFail("PrototypeFactory could not create a new object of type `Room`")
            return
        }
        XCTAssertFalse(firstRoomPrototype === secondRoomPrototype)
        XCTAssert(firstRoomPrototype ==  secondRoomPrototype)
    }
}
