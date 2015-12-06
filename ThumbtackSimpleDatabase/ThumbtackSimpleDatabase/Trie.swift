//
//  Trie.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/4/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class Trie {
    private var transactionID: Int
    private var keyIndexedTrie: TrieNode
    private var valuesIndexedTrie: TrieNode
    private var keysInTransaction : [Set<String>]
    private var valuesInTransaction : [Set<String>]

    init() {
        self.keyIndexedTrie = TrieNode()
        self.valuesIndexedTrie = TrieNode()
        self.transactionID = 0
        self.keysInTransaction = [[]]
        self.valuesInTransaction = [[]]
    }
    
    func put(key: String, value: String) -> Void {
        self.keysInTransaction[self.transactionID].insert(key)
        self.valuesInTransaction[self.transactionID].insert(value)
        let oldValues : [String] = self.keyIndexedTrie.put(key, value: value, acceptsMultipleValuesForKey: false, transactionID: self.transactionID)
        assert(oldValues.count <= 1)
        let oldValue: String? = oldValues.first
        if (oldValue != nil) {
            self.valuesIndexedTrie.remove(oldValue!, value: key, transactionID: self.transactionID)
        }
        self.valuesIndexedTrie.put(value, value: key, acceptsMultipleValuesForKey: true, transactionID: self.transactionID)
    }
    
    func remove(key: String) -> Void {
        let oldValue: String? = self.keyIndexedTrie.get(key, transactionID: self.transactionID)
        if (oldValue != nil) {
            self.keyIndexedTrie.remove(key, value: oldValue!, transactionID: self.transactionID)
            self.valuesIndexedTrie.remove(oldValue!, value: key, transactionID: self.transactionID)
        }
    }
    
    func get(key: String) -> String? {
        return self.keyIndexedTrie.get(key, transactionID: self.transactionID)
    }
    
    func getAllValuesFor(key: String) -> [String]? {
        return self.valuesIndexedTrie.getAllValues(key, transactionID: self.transactionID)
    }

    func description() -> String {
        return self.keyIndexedTrie.description(self.transactionID).stringByAppendingString("\n\n").stringByAppendingString(self.valuesIndexedTrie.description(self.transactionID))
    }
    
    func begin() -> Void {
        self.transactionID += 1
        keysInTransaction.append([])
        valuesInTransaction.append([])
    }

    func rollback() -> Bool {
        if (self.transactionID <= 0) {
            return false
        }

        assert(self.transactionID == self.keysInTransaction.count - 1)
        assert(self.transactionID == self.valuesInTransaction.count - 1)

        for key in self.keysInTransaction.last! {
            self.keyIndexedTrie.rollback(key, transactionID: self.transactionID)
        }
        for value in self.valuesInTransaction.last! {
            self.valuesIndexedTrie.rollback(value, transactionID: self.transactionID)
        }
        self.transactionID--
        self.keysInTransaction.removeLast()
        self.valuesInTransaction.removeLast()
        return true
    }

    func commit() -> Bool {
        if (self.transactionID <= 0) {
            return false
        }
        
        assert(self.transactionID == self.keysInTransaction.count - 1)
        assert(self.transactionID == self.valuesInTransaction.count - 1)
        
        for key in self.keysInTransaction.last! {
            self.keyIndexedTrie.commit(key, transactionID: self.transactionID)
        }
        for value in self.valuesInTransaction.last! {
            self.valuesIndexedTrie.commit(value, transactionID: self.transactionID)
        }
        self.transactionID--
        self.keysInTransaction.removeLast()
        self.valuesInTransaction.removeLast()
        return true
    }
}
