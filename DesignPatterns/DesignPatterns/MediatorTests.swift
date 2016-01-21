//
//  MediatorTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/24/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class MediatorTests : SampleTest {
    class func runSamples() {
        let mediator: Mediator = Mediator(id: "mediator1")
        let client1: Client = Client(id: "client1", mediator: mediator)
        mediator.addClient(client1)
        
        let client2: Client = Client(id: "client2", mediator: mediator)
        mediator.addClient(client2)
        
        let client3: Client = Client(id: "client3", mediator: mediator)
        mediator.addClient(client3)
        
        // client2 and client3 are notified by the state change of client1
        client1.mutate()
    }
}