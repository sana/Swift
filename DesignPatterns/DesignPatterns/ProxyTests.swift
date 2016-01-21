//
//  ProxyTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation


class ProxyTests : SampleTest {
    private class func addElements(database: Database) {
        database.begin()
        database.set("value1", key: "key1")
        database.set("value2", key: "key2")
        database.set("value3", key: "key3")
        database.commit()
    }
    
    class func runSamples() {
        let simpleDatabase: Database = SimpleDatabase()
        addElements(simpleDatabase)
        print(simpleDatabase)
        
        let nsUserDefaultsDatabase: Database = NSUserDefaultsDatabase()
        addElements(nsUserDefaultsDatabase)
        print(nsUserDefaultsDatabase)

        let proxyDatabase: Database = ProxyDatabase(commitThreshold: 2, forbiddenKeys: nil)
        addElements(proxyDatabase)
        print(proxyDatabase)

        let protectionProxyDatabase: Database = ProxyDatabase(commitThreshold: 2, forbiddenKeys: ["key1", "key2"])
        addElements(protectionProxyDatabase)
        print(protectionProxyDatabase)
    }
}