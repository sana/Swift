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
//    AbstractFactoryTests.self,
//    BuilderTests.self,
//    FactoryTests.self,
//    PrototypeTests.self,
//    SingletonTests.self,
//    ObjectPoolTests.self,
//    AdapterTests.self,
//    BridgeTests.self,
//    CompositeTests.self,
//    DecoratorTests.self,
//    FacadeTests.self,
//    FlyweightTests.self,
//    ProxyTests.self,
//    ChainOfResponsibilityTests.self,
//    CommandTests.self,
//    MediatorTests.self,
//    MementoTests.self,
//    ObserverTests.self,
//    StateTests.self,
//    StrategyTests.self,
//    TemplateMethodTests.self,
//    VisitorTests.self,
//    FutureTests.self,
//    BalkingObjectTests.self,
//    ActiveObjectTests.self,
//    IteratorTests.self,
//    TreeTests.self,
//    BinarySearchTreeTests.self, // FIXME: implement the iterative options using iterator
    //GraphTests.self // FIXME: some graph algorithms
]

for testClass in testClasses {
    testClass.runSamples()
}

/*
Algo #1 (priority to readers)

readErr
  readCount = 0
  mutex = 1, w = 1

READER
P(mutex)
readCount++
if readCount == 1
  P(w)
V(mutex)

// reading is performed

P(mutex)
readCount--
if readCount == 0
  V(w)
V(mutex)


WRITER

P(w)
write is performed
V(w)


Algo #2 (priority to writers)

READER
P(mutex3)
  P(r)
    P(mutex1)
    readCount++
    if readCount == 1 P(w)
    V(mutex1)
  V(r)
V(mutex3)

// read is performed

P(mutex1)
readCount--
if readCount == 0 V(w)
V(mutex1)


WRITER

P(mutex2)
writeCount++
if writeCount == 1 P(r)
V(mutex2)

P(w)
// write is performed
V(w)

P(mutex2)
writeCount--
if writeCount == 0 V(r)
V(mutex2)
*/
