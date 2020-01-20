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

protocol ClientNotifier {
}

protocol Client : Hashable, CustomStringConvertible {
    var id: String { get }
    var mediator: Mediator { get }

    func mutate()
    func notify(mediator: Mediator)
}

extension Client {
    var description: String {
        return "#\( self.id )"
    }
}

class AnyClient: Client {
    let id: String
    var mediator: Mediator

    init(id: String, mediator: Mediator) {
        self.id = id
        self.mediator = mediator
    }

    func mutate() {
        mediator.clientHasChanged(client: self)
    }

    func notify(mediator: Mediator) { /* override */ }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AnyClient, rhs: AnyClient) -> Bool {
        return lhs.id == rhs.id
    }
}

class Mediator : CustomStringConvertible {
    private let id: String
    private var clients: Set<AnyClient>
    
    init(id: String) {
        self.id = id
        clients = Set<AnyClient>()
    }
    
    func addClient(client: AnyClient) {
        clients.insert(client)
    }
    
    func removeClient(client: AnyClient) {
        clients.remove(client)
    }
    
    func clientHasChanged(client: AnyClient) {
        for it in clients {
            if it != client {
                it.notify(mediator: self)
            }
        }
    }
    
    var description: String {
        return id
    }
}
