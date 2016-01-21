//
//  MementoTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class MementoTests : SampleTest {
    class func runSamples() {
        let mementoObject: MementoObject = MementoObject(id: "initial_state")
        print(mementoObject)
        let mementoState: MementoState = mementoObject.getState()
        mementoObject.id = "mutated_state"
        print(mementoObject)
        mementoObject.setState(mementoState)
        print(mementoObject)
    }
}