//
//  BridgeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class BridgeTests : SampleTest {
    class func runSamples() {
        let source: SourceProtocol = SourceClass()
        let bridge: BridgeClass = BridgeClass(source: source)
        bridge.target = TargetClass()
        bridge.printTokens()
    }
}
