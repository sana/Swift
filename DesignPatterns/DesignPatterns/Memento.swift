//
//  Memento.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Without violating encapsulation, capture and externalize an object's internal
 state so that the object can be restored to this state later.
 */
class MementoState {
    var id: String
    init(id: String) {
        self.id = id
    }
}

class MementoObject : PrintableClass {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func getState() -> MementoState {
        return MementoState(id: id)
    }
    
    func setState(state: MementoState) -> Bool {
        id = state.id
        return true
    }

    func stringValue() -> String {
        return id
    }
}
