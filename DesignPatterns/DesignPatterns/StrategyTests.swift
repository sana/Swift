//
//  StrategyTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class StrategyTests : SampleTest {
    class func runSamples() {
        let printer: Printer = Printer()
        print(printer.prepareForPrinting("Hi!"))
        
        printer.printStrategy = LowercasePrintStrategy()
        print(printer.prepareForPrinting("Hi!"))
        
        printer.printStrategy = UppercasePrintStrategy()
        print(printer.prepareForPrinting("Hi!"))
    }
}