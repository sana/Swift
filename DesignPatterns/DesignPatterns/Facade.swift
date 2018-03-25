//
//  Facade.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

/**
 Provide a uniform interface to a set of interfaces in a subsystem. Facade
 defines a higher-level interface that makes the subsystem easier to use.
 */
protocol CacheFacade {
    func get(valueForKey key: String) -> String?
    func set(value: String, forKey key: String, ttl: DateInterval?) -> Bool
    func delete(valueForKey key: String) -> Bool
    func clear() -> Bool
    func get(multipleValuesForKeys keys: [String]) -> [(key: String, value: String)]
    func set(multipleValuesForKeys keyValuePairs: [(key: String, value: String)]) -> Bool
    func delete(multipleValuesForKeys keys: [String]) -> Bool
    func contains(key: String) -> Bool
}

