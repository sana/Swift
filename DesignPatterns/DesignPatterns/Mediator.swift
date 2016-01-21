//
//  Mediator.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Define an object that encapsulates how a set of objects interact. Mediator
 promotes loose coupling by keeping objects from referring each to other
 explictly, and it lets you vary their interaction independently.
 */
class Client : Hashable, PrintableClass {
    private let id: String
    private var mediator: Mediator
    init(id: String, mediator: Mediator) {
        self.id = id
        self.mediator = mediator
    }
    
    func mutate() {
        mediator.clientHasChanged(self)
    }
    
    func notify(mediator: Mediator) {
        print("Client \( self ) is notified by mediator \( mediator )")
    }
    
    var hashValue : Int {
        get {
            return unsafeAddressOf(self).hashValue
        }
    }

    func stringValue() -> String {
        return "#\( self.id )"
    }
}

func ==(left: Client, right: Client) -> Bool {
    return left.hashValue == right.hashValue
}

class Mediator : PrintableClass {
    private let id: String
    private var clients: Set<Client>
    
    init(id: String) {
        self.id = id
        clients = Set<Client>()
    }
    
    func addClient(client: Client) {
        clients.insert(client)
    }
    
    func removeClient(client: Client) {
        clients.remove(client)
    }
    
    func clientHasChanged(client: Client) {
        for it in clients {
            if it != client {
                it.notify(self)
            }
        }
    }
    
    func stringValue() -> String {
        return id
    }
}