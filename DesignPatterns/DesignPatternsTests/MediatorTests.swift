//
//  MediatorTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/2/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class MySimpleClient : AnyClient {
    let expectation: XCTestExpectation?

    init(id: String, mediator: Mediator, expectation: XCTestExpectation?) {
        self.expectation = expectation
        super.init(id: id, mediator: mediator)
    }

    override func notify(mediator: Mediator) {
        self.expectation?.fulfill()
    }
}

class MediatorTests : XCTestCase {
    func testFoo() {
        let mediator: Mediator = Mediator(id: "mediator1")
        let client1: AnyClient = MySimpleClient(id: "client1", mediator: mediator, expectation: nil)
        mediator.addClient(client: client1)

        let expectation2 = expectation(description: "client2 expectation")
        let client2: AnyClient = MySimpleClient(id: "client2", mediator: mediator, expectation: expectation2)
        mediator.addClient(client: client2)

        let expectation3 = expectation(description: "client3 expectation")
        let client3: AnyClient = MySimpleClient(id: "client3", mediator: mediator, expectation: expectation3)
        mediator.addClient(client: client3)

        // client2 and client3 are notified by the state change of client1
        client1.mutate()

        // The expectation should execute synchronously
        waitForExpectations(timeout: 0, handler: nil)
    }
}
