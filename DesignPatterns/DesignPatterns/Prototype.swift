//
//  Prototype.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Specify the kinds of objects to create using a prototyped instance, and create
 new objects by copying this prototype.
 */
protocol Prototype : PrintableClass {
    func clone() -> Prototype
}

class Room : Prototype {
    private var name: String?
    
    init(name : String?) {
        self.name = name
    }
    
    func clone() -> Prototype {
        return Room(name: "default")
    }
    
    func stringValue() -> String {
        return "Room \(name ?? "")"
    }
}

class Door : Prototype {
    var room1: Room?
    var room2: Room?
    
    init(room1: Room?, room2: Room?) {
        self.room1 = room1
        self.room2 = room2
    }

    func clone() -> Prototype {
        return Door(room1: Room(name: "default1"), room2: Room(name: "default2"))
    }
    
    func stringValue() -> String {
        return "Door [\((room1?.stringValue() ?? "none")), \((room2?.stringValue() ?? "none"))]"
    }
}

class PrototypeFactory {
    static let classMappings: [String: Prototype] = [
        "Room": Room(name: "unnamed"),
        "Door": Door(room1: nil, room2: nil),
    ]
    
    class func createNewObject(className: String) -> Prototype? {
        let prototype: Prototype? = classMappings[className]
        if let prototypeValue = prototype {
            return prototypeValue.clone()
        }
        return nil
    }
}