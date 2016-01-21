//
//  StateTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class StateTests : SampleTest {
    class func runSamples() {
        print("A state object containing just the current delegate")
        let simpleGreet : MutableStateDelegate = SimpleGreet()
        print(simpleGreet.state())
        simpleGreet.updateCurrentState(.Active)
        print(simpleGreet.state())
        
        print("A state object containing all the possible delegates")
        let fancyGreet : MutableStateDelegate = FancyGreet()
        print(fancyGreet.state())
        fancyGreet.updateCurrentState(.Active)
        print(fancyGreet.state())

    }
}