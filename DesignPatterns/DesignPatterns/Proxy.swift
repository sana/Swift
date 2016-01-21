//
//  Proxy.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Provide a surrogate or placeholder for another object to control access to it.
 */
protocol Database : PrintableClass {
    func set(value: AnyObject?, key: String) -> Bool
    func get(key: String) -> AnyObject?
    
    func begin() -> Bool
    func commit() -> Bool
}

extension Database {
    func begin() -> Bool {
        return false
    }
    
    func commit() -> Bool {
        return false
    }
}

class SimpleDatabase : Database {
    private var database: [String: AnyObject?]
    
    init() {
        database = [String: AnyObject?]()
    }
    
    func set(value: AnyObject?, key: String) -> Bool {
        database[key] = value
        return true
    }
    
    func get(key: String) -> AnyObject? {
        return database[key] ?? nil
    }

    func stringValue() -> String {
        return database.description
    }
}

class NSUserDefaultsDatabase : Database {
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    func set(value: AnyObject?, key: String) -> Bool {
        defaults.setObject(value, forKey: key)
        return true
    }
    
    func get(key: String) -> AnyObject? {
        return defaults.valueForKey(key)
    }
    
    func begin() -> Bool {
        return true
    }
    
    func commit() -> Bool {
        return defaults.synchronize()
    }
    
    func stringValue() -> String {
        return defaults.dictionaryRepresentation().description
    }
}

/* A simple proxy that wraps two database objects: an in-memory database and a
plist based database that is synchronized when commitThreshold keys have their
values mutated. The proxy acts also as a authenticator, being able to filter out
all the mutations of the forbiddenKeys.
*/
class ProxyDatabase : Database {
    private var keys: Set<String>
    private let simpleDatabase : Database
    private let nsUserDefaulsDatabase : Database
    private let commitThreshold: Int
    private let forbiddenKeys: [String]?
    
    init(commitThreshold: Int, forbiddenKeys: [String]?) {
        simpleDatabase = SimpleDatabase()
        nsUserDefaulsDatabase = NSUserDefaultsDatabase()
        keys = Set<String>()
        self.commitThreshold = commitThreshold
        self.forbiddenKeys = forbiddenKeys
    }
    
    func set(value: AnyObject?, key: String) -> Bool {
        if (forbiddenKeys?.contains(key) ?? false) {
            return false
        }
        keys.insert(key)
        if (keys.count > commitThreshold) {
            commit()
        }
        return simpleDatabase.set(value, key: key)
    }
    
    func get(key: String) -> AnyObject? {
        return simpleDatabase.get(key)
    }
    
    private func commit() {
        nsUserDefaulsDatabase.begin()
        for key in keys {
            nsUserDefaulsDatabase.set(get(key), key: key)
        }
        nsUserDefaulsDatabase.commit()
        keys.removeAll()
    }
    
    func stringValue() -> String {
        return "Keys: \( keys.description ), In-memory DB: \( simpleDatabase.stringValue() ), Persistent DB: \( nsUserDefaulsDatabase.stringValue() )"
    }
}
