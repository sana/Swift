//
//  SingletonTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class SingletonTests : SampleTest {
    private class func printObjectAndMemoryAddress(object: Singleton?) {
        print(object)
        if let _ = object {
            print("Memory address \(unsafeAddressOf(object!))")
        }
        print("")
    }
    
    class func runSamples() {
        printObjectAndMemoryAddress(Singleton.sharedInstance())
        printObjectAndMemoryAddress(Singleton.sharedInstance())
        printObjectAndMemoryAddress(Singleton.sharedInstance())
        printObjectAndMemoryAddress(Multiton.getInstance("foo"))
        printObjectAndMemoryAddress(Multiton.getInstance("foo"))
        printObjectAndMemoryAddress(Multiton.getInstance("bar"))
        printObjectAndMemoryAddress(Multiton.getInstance("bar"))
    }
}
