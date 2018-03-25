//
//  Singleton.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class AbstractSingleton {
    class func sharedInstance() -> AbstractSingleton? {
        return nil
    }
}

/**
 Intent: Ensure a class has a single instance, and provide a global point of access to it.
 */

// MARK :- Thread safe Singleton

class Singleton : AbstractSingleton, CustomStringConvertible {
    private static let kSingletonName = "singleton"
    private static var sharedInstanceImpl: Singleton?
    private static let privateConcurrentQueue = DispatchQueue(label: "Singleton.Queue", attributes: .concurrent)

    private let name: String

    fileprivate init(name: String) {
        self.name = name
    }

    override class func sharedInstance() -> AbstractSingleton? {
        privateConcurrentQueue.sync(flags: .barrier) {
            if (sharedInstanceImpl == nil) {
                sharedInstanceImpl = Singleton(name: Singleton.kSingletonName)
            }
        }
        return sharedInstanceImpl
    }
    
    var description: String {
        return "Singleton-\(name)"
    }
}

// MARK :- Main thread Singleton

class MainThreadSingleton : AbstractSingleton, CustomStringConvertible {
    private static let kSingletonName = "main-thread-singleton"
    private static var sharedInstanceImpl: Singleton?

    private let name: String

    fileprivate init(name: String) {
        self.name = name
    }

    override class func sharedInstance() -> AbstractSingleton? {
        guard Thread.isMainThread else {
            return nil
        }
        if (sharedInstanceImpl == nil) {
            sharedInstanceImpl = Singleton(name: MainThreadSingleton.kSingletonName)
        }
        return sharedInstanceImpl
    }

    var description: String {
        return "MainThreadSingleton-\(name)"
    }
}

// MARK :- Thread safe Multiton

class Multiton {
    private static let privateConcurrentQueue = DispatchQueue(label: "Multiton.Queue", attributes: .concurrent)
    private static var multitonInstances = [String: Singleton]()

    class func getInstance(key: String) -> Singleton? {
        privateConcurrentQueue.sync(flags: .barrier) {
            if (multitonInstances[key] == nil) {
                multitonInstances[key] = Singleton(name: key)
            }
        }
        return multitonInstances[key]
    }
}

// MARK :- Main thread Multiton

class MainThreadMultiton {
    private static var multitonInstances = [String: Singleton]()

    class func getInstance(key: String) -> Singleton? {
        if (multitonInstances[key] == nil) {
            multitonInstances[key] = Singleton(name: key)
        }
        return multitonInstances[key]
    }
}
