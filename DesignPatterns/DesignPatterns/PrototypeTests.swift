//
//  PrototypeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class PrototypeTests : SampleTest {
    class func runSamples() {
        print(PrototypeFactory.createNewObject("foo"))
        print(PrototypeFactory.createNewObject("Door"))
        print(PrototypeFactory.createNewObject("Room"))
        print(PrototypeFactory.createNewObject("Room"))
        print(PrototypeFactory.createNewObject("Door"))
    }
}
