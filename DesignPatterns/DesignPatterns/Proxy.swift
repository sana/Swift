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
protocol Database : CustomStringConvertible {
    func set(value: Any?, key: String) -> Bool
    func get(key: String) -> Any?

    func begin() -> Bool
    func commit() -> Bool
    func keys() -> [String]
}

extension Database {
    func begin() -> Bool {
        return false
    }
    
    func commit() -> Bool {
        return false
    }

    func keys() -> [String] {
        return []
    }
}

// MARK :- SimpleDatabase

class SimpleDatabase : Database {
    private var database: [String: Any?]
    
    init() {
        database = [String: Any?]()
    }

    func begin() -> Bool {
        return true
    }

    func commit() -> Bool {
        return true
    }

    func set(value: Any?, key: String) -> Bool {
        database[key] = value
        return true
    }

    func get(key: String) -> Any? {
        return database[key] ?? nil
    }

    var description: String {
        return database.description
    }

    func keys() -> [String] {
        return Array(database.keys)
    }
}

// MARK :- NSUserDefaultsDatabase

class NSUserDefaultsDatabase : Database {
    let defaults: UserDefaults = UserDefaults.standard

    func begin() -> Bool {
        return true
    }

    func commit() -> Bool {
        return defaults.synchronize()
    }

    func set(value: Any?, key: String) -> Bool {
        defaults.set(value, forKey: key)
        return true
    }

    func get(key: String) -> Any? {
        return defaults.value(forKey: key) as Any
    }

    var description: String {
        return defaults.dictionaryRepresentation().description
    }
}

// MARK :- ProxyDatabase

/**
 A simple proxy that wraps two database objects: an in-memory database and a
 plist based database that is synchronized when commitThreshold keys have their
 values mutated. The proxy acts also as a authenticator, being able to filter out
 all the mutations of the forbiddenKeys.
*/
class ProxyDatabase : Database {
    private var keysSet: Set<String>
    private let simpleDatabase : Database
    private let nsUserDefaulsDatabase : Database
    private let commitThreshold: Int
    private let forbiddenKeys: [String]?
    
    init(commitThreshold: Int, forbiddenKeys: [String]?) {
        simpleDatabase = SimpleDatabase()
        nsUserDefaulsDatabase = NSUserDefaultsDatabase()
        keysSet = Set<String>()
        self.commitThreshold = commitThreshold
        self.forbiddenKeys = forbiddenKeys
    }
    
    func set(value: Any?, key: String) -> Bool {
        if (forbiddenKeys?.contains(key) ?? false) {
            return false
        }
        keysSet.insert(key)
        if (keysSet.count > commitThreshold) {
            commit()
        }
        return simpleDatabase.set(value: value, key: key)
    }
    
    func get(key: String) -> Any? {
        return simpleDatabase.get(key: key)
    }
    
    private func commit() {
        _ = nsUserDefaulsDatabase.begin()
        for key in keysSet {
            let _ = nsUserDefaulsDatabase.set(value: get(key: key), key: key)
        }
        _ = nsUserDefaulsDatabase.commit()
        keysSet.removeAll()
    }
    
    var description: String {
        return "Keys: \( keysSet.description ), In-memory DB: \( simpleDatabase.description ), Persistent DB: \( nsUserDefaulsDatabase.description )"
    }

    func keys() -> [String] {
        return Array(keysSet)
    }
}
