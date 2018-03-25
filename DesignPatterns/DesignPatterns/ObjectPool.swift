//
//  ObjectPool.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Object pool contains a set of objects that are acquired and released by
 clients. The objects are allocated when the pool is created, not for every
 object acquisition.
 */
class Object : Hashable, CustomStringConvertible {
    private let id: String
    init(id: String) {
        self.id = id
    }
    
    var hashValue : Int {
        get {
            return id.hash
        }
    }
    
    var description: String {
        return "\( NSStringFromClass(type(of: self)) ) \( id )"
    }
}

func ==(left: Object, right: Object) -> Bool {
    return left.hashValue == right.hashValue
}

protocol ObjectPool {
    init(capacity: Int)
    func acquireObject() -> Object?
    func releaseObject(object: Object) -> Bool
}

class ObjectPoolImplementation : ObjectPool {
    private let capacity: Int
    private var acquiredObjects : Set<Object>
    private var releasedObjects : Set<Object>

    required init(capacity: Int) {
        self.capacity = capacity
        acquiredObjects = Set<Object>()
        releasedObjects = Set<Object>()
        for i in 1...capacity {
            releasedObjects.insert(Object(id: String(i)))
        }
    }
    
    func acquireObject() -> Object? {
        if releasedObjects.count == 0 {
            return nil
        }
        let result: Object = releasedObjects.removeFirst()
        acquiredObjects.insert(result)
        return result
    }
    
    func releaseObject(object: Object) -> Bool {
        if !acquiredObjects.contains(object) {
            return false
        }
        acquiredObjects.remove(object)
        releasedObjects.insert(object)
        return true
    }

}
