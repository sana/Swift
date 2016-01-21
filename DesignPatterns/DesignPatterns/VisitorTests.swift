//
//  VisitorTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/25/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class SimpleVisitor : Visitor {
    func visit(number: Int) {
        visit(String(number))
    }
    
    func visit(string: String) {
        print(string)
    }
}

class AggregateVisitor : Visitor, PrintableClass {
    private var total: Int
    
    init() {
        total = 0
    }
    
    func visit(number: Int) {
        total += number
    }
    
    func visit(string: String) {
        total += Int(string) ?? 0
    }
    
    func stringValue() -> String {
        return "Total \( String(total) )"
    }
}

class VisitorTests : SampleTest {
    class func runSamples() {
        let visitorCenter : VisitorCenter = VisitorCenter()
        
        let simpleVisitor : Visitor = SimpleVisitor()
        visitorCenter.visitObjects(simpleVisitor)
        
        let aggregateVisitor : AggregateVisitor = AggregateVisitor()
        print(aggregateVisitor)
        visitorCenter.visitObjects(aggregateVisitor)
        print(aggregateVisitor)
    }
}