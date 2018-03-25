//
//  DictionaryCacheImplementation.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class DictionaryCacheImplementation : CacheFacade {
    let dispatchQueue = DispatchQueue(label: "com.github.sana.DictionaryCacheImplementation", attributes: .concurrent)

    var dictionary = [String : String]()

    public func get(valueForKey key: String) -> String? {
        var result: String? = nil
        dispatchQueue.sync {
            // We support multiple readers
            result = dictionary[key]
        }
        return result
    }

    public func set(value: String, forKey key: String, ttl: DateInterval?) -> Bool {
        dispatchQueue.async(flags: .barrier) {
            // We support a single writer
            self.dictionary[key] = value
        }
        return true
    }

    public func delete(valueForKey key: String) -> Bool {
        guard self.contains(key: key) else {
            return false
        }
        dispatchQueue.async(flags: .barrier) {
            // Only one thread can write into `dictionary`
            self.dictionary[key] = nil
        }
        return true
    }

    public func clear() -> Bool {
        var dictionaryIsNotEmpty: Bool = true
        dispatchQueue.sync {
            dictionaryIsNotEmpty = dictionary.count != 0
        }
        guard dictionaryIsNotEmpty else {
            return false
        }
        dispatchQueue.async(flags: .barrier) {
            // Only one thread can write into `dictionary`
            self.dictionary = [String : String]()
        }
        return true
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
        for keyValuePair in keyValuePairs {
            result = self.set(value: keyValuePair.value, forKey: keyValuePair.key, ttl: nil) && result
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
