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
class Facade {
    class func set(value: AnyObject?, key: String) -> Bool {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: key)
        return defaults.synchronize()
    }
    
    class func get(key: String) -> AnyObject? {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return defaults.valueForKey(key)
    }
}
