//
//  TemplateMethodTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class TemplateMethodTests : SampleTest {
    class func runSamples() {
        let dummy: AbstractSentenseComposer = DummySentenseComposer()
        print(dummy.sentense())
        
        let smart: AbstractSentenseComposer = SmartSentenseComposer()
        print(smart.sentense())
    }
}