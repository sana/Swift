//
//  Singleton.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Ensure a class has a single instance, and provide a global point of access to
 it.
 */
class Singleton : PrintableClass {
    private var name: String
    private init(name: String) {
        self.name = name
    }
    
    private static var sharedInstanceImpl: Singleton?

    class func sharedInstance() -> Singleton? {
        if (sharedInstanceImpl == nil) {
            sharedInstanceImpl = Singleton(name: "singleton")
        }
        return sharedInstanceImpl
    }
    
    func stringValue() -> String {
        return "Singleton \(name)"
    }
}

class Multiton : PrintableClass {
    private static var multitonInstances: [String: Singleton]?
    private init() { }
    
    class func getInstance(key: String) -> Singleton? {
        if (multitonInstances == nil) {
            multitonInstances = [String: Singleton]()
        }
        if var multitonInstances = multitonInstances {
            if (multitonInstances[key] == nil) {
                multitonInstances[key] = Singleton(name: key)
            }
            Multiton.multitonInstances = multitonInstances
            return multitonInstances[key]
        }
        return nil
    }
    
    func stringValue() -> String {
        return "Singleton \(Multiton.multitonInstances)"
    }
}
