//
//  Prototype.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/22/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Intent: Specify the kinds of objects to create using a prototyped instance,
 and create new objects by copying this prototype.
 */
class Prototype : CustomStringConvertible {
    func clone() -> Prototype {
        return self
    }

    var description: String {
        return "\( Unmanaged.passUnretained(self).toOpaque() )"
    }
}

extension Prototype : Equatable {
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.description == rhs.description
    }
}

class Room : Prototype {
    fileprivate static let kDefaultRoomName = "default-room-name"
    private let name: String
    
    init(name : String) {
        self.name = name
    }
    
    override func clone() -> Prototype {
        return Room(name: Room.kDefaultRoomName)
    }
    
    override var description: String {
        return "Room-\(name)"
    }
}

class Door : Prototype {
    fileprivate static let kDefaultFirstRoomName = "default-first-room-name"
    fileprivate static let kDefaultSecondRoomName = "default-first-room-name"
    let firstRoom: Room
    let secondRoom: Room

    init(firstRoom: Room, secondRoom: Room) {
        self.firstRoom = firstRoom
        self.secondRoom = secondRoom
    }

    override func clone() -> Prototype {
        return Door(firstRoom: Room(name: Door.kDefaultFirstRoomName), secondRoom: Room(name: Door.kDefaultSecondRoomName))
    }
    
    override var description: String {
        return "Door [\((firstRoom.description)), \((secondRoom.description))]"
    }
}

class PrototypeFactory {
    static let classMappings: [String: Prototype] = [
        "Room": Room(name: Room.kDefaultRoomName),
        "Door": Door(firstRoom: Room(name: Door.kDefaultFirstRoomName), secondRoom: Room(name: Door.kDefaultSecondRoomName))
    ]
    
    class func createNewObject(className: String) -> Prototype? {
        let prototype: Prototype? = classMappings[className]
        if let prototypeValue = prototype {
            return prototypeValue.clone()
        }
        return nil
    }
}
