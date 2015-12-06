//
//  TrieNode.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/6/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class TrieNode {
    private var key: Character?
    private var values: [[String]] // stack of most recent values in the leaf node
    private var children: Dictionary<Character, TrieNode>?
    
    convenience init() {
        self.init(key: nil)
    }
    
    init(key: Character?) {
        self.key = key
        self.values = []
    }
    
    func put(key: String, value: String, acceptsMultipleValuesForKey: Bool, transactionID: Int) -> [String] {
        if (key.characters.count == 0) {
            self._updateValuesForTransactionID(transactionID)
            let oldValues: [String] = values[transactionID]
            var currentValues: [String] = oldValues
            if (acceptsMultipleValuesForKey || currentValues.count == 0) {
                currentValues.append(value)
            } else {
                assert(currentValues.count == 1)
                currentValues[0] = value
            }
            values[transactionID] = currentValues
            return oldValues
        }
        
        if (self.children == nil) {
            self.children = Dictionary()
        }
        
        let firstChar: Character = key.characters.first!
        var nextNode: TrieNode
        if (self.children!.indexForKey(firstChar) == nil) {
            nextNode = TrieNode()
            self.children!.updateValue(nextNode, forKey:firstChar)
        } else {
            nextNode = self.children![firstChar]!
        }
        return nextNode.put(key.substringFromIndex(key.startIndex.advancedBy(1)), value: value, acceptsMultipleValuesForKey: acceptsMultipleValuesForKey, transactionID: transactionID)
    }
    
    func remove(key: String, value: String, transactionID: Int) {
        if (key.characters.count == 0) {
            self._updateValuesForTransactionID(transactionID)
            self.values[transactionID].remove(value)
        } else {
            let firstChar: Character = key.characters.first!
            let nextNode: TrieNode? = self.children?[firstChar]
            nextNode?.remove(key.substringFromIndex(key.startIndex.advancedBy(1)), value: value, transactionID: transactionID)
        }
    }
    
    func get(key: String, transactionID: Int) -> String? {
        if (key.characters.count == 0) {
            if (transactionID < self.values.count) {
                return self.values[transactionID].first
            }
            return self.values.last?.first
        }
        let firstChar: Character = key.characters.first!
        let nextNode: TrieNode? = self.children![firstChar]
        if (nextNode != nil) {
            return nextNode!.get(key.substringFromIndex(key.startIndex.advancedBy(1)), transactionID: transactionID)
        }
        return nil
    }
    
    func getAllValues(key: String, transactionID: Int) -> [String] {
        if (key.characters.count == 0) {
            if (transactionID >= self.values.count) {
                return self.values.last!
            }
            return self.values[transactionID]
        }
        let firstChar: Character = key.characters.first!
        let nextNode: TrieNode? = self.children![firstChar]
        if (nextNode != nil) {
            return nextNode!.getAllValues(key.substringFromIndex(key.startIndex.advancedBy(1)), transactionID: transactionID)
        }
        return []
    }
    
    func rollback(key: String, transactionID: Int) {
        if (key.characters.count == 0) {
            while (self.values.count > transactionID) {
                self.values.removeLast()
            }
        } else {
            let firstChar: Character = key.characters.first!
            let nextNode: TrieNode? = self.children![firstChar]
            if (nextNode != nil) {
                nextNode!.rollback(key.substringFromIndex(key.startIndex.advancedBy(1)), transactionID: transactionID)
            }
        }
    }
    
    func commit(key: String, transactionID: Int) {
        if (key.characters.count == 0) {
            self.values[transactionID - 1] = self.values[transactionID]
            self.values.removeLast()
        } else {
            let firstChar: Character = key.characters.first!
            let nextNode: TrieNode? = self.children![firstChar]
            if (nextNode != nil) {
                nextNode!.commit(key.substringFromIndex(key.startIndex.advancedBy(1)), transactionID: transactionID)
            }
        }
    }
    
    private func _description(rootDescription: String, transactionID: Int) -> String {
        if (self.children == nil || self.children!.count == 0) {
            let nodeDescription: String = (transactionID < self.values.count) ? self.values[transactionID].description : self.values.last!.description
            return "(".stringByAppendingFormat("%@,%@)", rootDescription, nodeDescription)
        }
        return self.children!.map { (char: Character, t: TrieNode) -> String in
            return t._description(rootDescription + String(char), transactionID: transactionID)
            }.joinWithSeparator(", ")
    }
    
    func description(transactionID: Int) -> String {
        return self._description("", transactionID: transactionID)
    }
    
    private func _updateValuesForTransactionID(transactionID: Int) {
        if (transactionID >= self.values.count) {
            for _ in self.values.count...transactionID {
                let lastValues: [String]? = self.values.last
                if (lastValues != nil) {
                    self.values.append(lastValues!)
                } else {
                    self.values.append([])
                }
            }
        }
    }
}
