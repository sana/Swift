//
//  Observer.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Define a one-to-many dependency between objects so that when one object changes
 state, all its dependencies are notified and updated automatically.
 */
class SubjectOrObserver : Hashable {
    // notify all the observers that the subject has changed
    func notify() { }

    // notify that subject has changed
    func update(subject: Subject) { }

    var hashValue : Int {
        get {
            return Unmanaged.passUnretained(self).toOpaque().hashValue
        }
    }
}

class Subject : SubjectOrObserver {
    private let id: String
    init(id: String) {
        self.id = id
    }
    
    func attach(observer: SubjectOrObserver) {
        ChangeManager.sharedInstance()?.register(subject: self, observer: observer)
    }

    func detach(observer: SubjectOrObserver) {
        ChangeManager.sharedInstance()?.unregister(subject: self, observer: observer)
    }
    
    // notify all the observers that the subject has changed
    override func notify() {
        ChangeManager.sharedInstance()?.notify(subject: self)
    }

    override func update(subject: SubjectOrObserver) { /* override */ }
    
    var description: String {
        return id
    }
}

class Observer : SubjectOrObserver {
    private let id: String
    init(id: String) {
        self.id = id
    }
    
    override func update(subject: SubjectOrObserver) {
        print("\( self ) got notified for \( subject )")
    }

    var description : String {
        return id
    }
}

func ==(left: SubjectOrObserver, right: SubjectOrObserver) -> Bool {
    return left.hashValue == right.hashValue
}

class ChangeManager {
    private var mappings: [SubjectOrObserver: Set<SubjectOrObserver>]
    private static var sharedInstanceImpl: ChangeManager?
    
    private init() {
        self.mappings = [SubjectOrObserver: Set<SubjectOrObserver>]()
    }
    
    class func sharedInstance() -> ChangeManager? {
        if (sharedInstanceImpl == nil) {
            sharedInstanceImpl = ChangeManager()
        }
        return sharedInstanceImpl
    }
    
    func register(subject: Subject, observer: SubjectOrObserver) {
        if var mapping = mappings[subject] {
            mapping.insert(observer)
            mappings[subject] = mapping
        } else {
            mappings[subject] = Set<SubjectOrObserver>(arrayLiteral: observer)
        }
    }

    func unregister(subject: Subject, observer: SubjectOrObserver) -> Bool {
        if var mapping = mappings[subject] {
            let result: Bool = (mapping.remove(observer) != nil) ? true : false
            mappings[subject] = mapping
            return result
        }
        return false
    }

    func notify(subject: Subject) {
        // Compute the directly acyclic graph for the observers that need to
        // be notified, because of potential circular dependencies.
        if let mapping = mappings[subject] {
            // Observers to be notified by the change of the subjects
            var observers: Set<SubjectOrObserver> = mapping
            var tmp : Set<SubjectOrObserver> = Set<SubjectOrObserver>()
            var foundNewObservers: Bool
            repeat {
                foundNewObservers = false
                for observer in observers {
                    if let mapping = mappings[observer] {
                        for item in mapping {
                            tmp.insert(item)
                        }
                    }
                }
                for item in tmp {
                    if (!observers.contains(item)) {
                        foundNewObservers = true
                        observers.insert(item)
                    }
                }
            } while(foundNewObservers)
            
            for observer in observers {
                observer.update(subject: subject)
            }
        }
    }
}
