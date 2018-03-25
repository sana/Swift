//
//  UserDefaultsCacheImplementation.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class UserDefaultsCacheImplementation : CacheFacade {
    var keys = Set<String>()
    let defaults: UserDefaults = UserDefaults.standard

    public func get(valueForKey key: String) -> String? {
        guard Thread.isMainThread else {
            return nil
        }
        return defaults.value(forKey: key) as? String
    }

    public func set(value: String, forKey key: String, ttl: DateInterval?) -> Bool {
        guard
            Thread.isMainThread,
            ttl == nil
        else {
            return false
        }
        keys.insert(key)
        defaults.set(value, forKey: key)
        return true
    }

    public func delete(valueForKey key: String) -> Bool {
        guard Thread.isMainThread else {
            return false
        }
        keys.remove(key)
        guard self.get(valueForKey: key) != nil else {
            return false
        }
        defaults.set(nil, forKey: key)
        return true
    }

    public func clear() -> Bool {
        guard
            Thread.isMainThread,
            self.keys.count > 0
        else {
            return false
        }
        return self.delete(multipleValuesForKeys: Array(self.keys))
    }

    public func get(multipleValuesForKeys keys: [String]) -> [(key: String, value: String)] {
        var result = [(String, String)]()
        for key in keys {
            guard let value = self.get(valueForKey: key) else {
                continue
            }
            result.append((key, value))
        }
        return result
    }

    public func set(multipleValuesForKeys keyValuePairs: [(key: String, value: String)]) -> Bool {
        var result = true
        for pair in keyValuePairs {
            result = self.set(value: pair.value, forKey: pair.key, ttl: nil) && result
        }
        return result
    }

    public func delete(multipleValuesForKeys keys: [String]) -> Bool {
        var result = true
        for key in keys {
            result = self.delete(valueForKey: key) && result
        }
        return result
    }

    public func contains(key: String) -> Bool {
        return self.get(valueForKey: key) != nil
    }
}
