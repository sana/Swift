//
//  main.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/21/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol SampleTest {
    static func runSamples()
}

let testClasses: [SampleTest.Type] = [
    AbstractFactoryTests.self,
    BuilderTests.self,
    FactoryTests.self,
    PrototypeTests.self,
    SingletonTests.self,
    ObjectPoolTests.self,
    AdapterTests.self,
    BridgeTests.self,
    CompositeTests.self,
    DecoratorTests.self,
    FacadeTests.self,
    FlyweightTests.self,
    ProxyTests.self,
    ChainOfResponsibilityTests.self,
    CommandTests.self,
    MediatorTests.self,
    MementoTests.self,
    ObserverTests.self,
    StateTests.self,
    StrategyTests.self,
    TemplateMethodTests.self,
    VisitorTests.self,
    FutureTests.self,
    BalkingObjectTests.self,
    ActiveObjectTests.self,
]

for testClass in testClasses {
    testClass.runSamples()
}
