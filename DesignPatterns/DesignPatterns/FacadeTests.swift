//
//  FacadeTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class FacadeTests : SampleTest {
    class func runSamples() {
        print(Facade.set("bar", key: "foo"))
        print(Facade.get("foo"))
        print(Facade.get("buzz"))
    }
}