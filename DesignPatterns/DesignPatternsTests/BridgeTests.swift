//
//  BridgeTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 3/29/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class BridgeTests : XCTestCase {
    func testBridgeBetweenTwoProtocols() {
        let source: SourceProtocol = SourceClass()
        let target: TargetProtocol = TargetClass()
        let bridge: BridgeClass = BridgeClass(source: source)
        XCTAssertEqual(bridge.tokens(forTarget: target), ["I", "want", "to", "break", "free!"])
    }
}
