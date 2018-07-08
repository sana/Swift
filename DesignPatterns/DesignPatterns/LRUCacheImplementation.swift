//
//  LRUCacheImplementation.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 7/7/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

protocol Cache {
    func get(valueForKey key: String) -> String?
    func set(value: String, forKey key: String) -> Bool // returns false if an older key has been evacuated
    func dictionary() -> [String: String]
}

class DoublyLinkedList<T> {
    let value: T
    var prev: DoublyLinkedList<T>?
    var next: DoublyLinkedList<T>?
    init(value: T, prev: DoublyLinkedList<T>?, next: DoublyLinkedList<T>?) {
        self.value = value
        self.prev = prev
        self.next = next
    }
}

class LRUCache : Cache {
    public let size: Int
    private var map: [String : String]
    private var keysSet: Set<String>

    private var linkedList: DoublyLinkedList<String>? // sorted by least recently used
    private var linkedListTail: DoublyLinkedList<String>? // end of `linkedList`
    private var listMap: [String: DoublyLinkedList<String>] // list node for a key

    init(size: Int) {
        self.size = size
        map = [String : String]()
        keysSet = Set<String>()
        listMap = [String : DoublyLinkedList<String>]()
    }

    func get(valueForKey key: String) -> String? {
        return map[key]
    }

    func set(value: String, forKey key: String) -> Bool {
        var result = false
        if keysSet.count < self.size {
            let newListNode = DoublyLinkedList<String>(value: key, prev: linkedListTail, next: nil)
            listMap[key] = newListNode
            if linkedList == nil {
                linkedList = newListNode
            }
            linkedListTail?.next = newListNode
            linkedListTail = newListNode
            result = true
        } else {
            // keysSet.count == self.size
            if keysSet.contains(key) {
                // Find `key` in `linkedList` and move it to the end of the list
                guard let listNode = listMap[key] else {
                    assert(false)
                }
                if
                    let listHead = linkedList,
                    listNode.value == listHead.value
                {
                    linkedList = linkedList?.next
                }
                listNode.prev?.next = listNode.next
                listNode.next?.prev = listNode.prev
                linkedListTail?.next = listNode
                listNode.prev = linkedListTail
                listNode.next = nil
                linkedListTail = listNode
                result = false
            } else {
                // Remove the first key in the linked list and add the new key to the end of the linked list
                guard let headNode = linkedList else {
                    assert(false)
                }
                let evacuatedKey = headNode.value
                listMap[evacuatedKey] = nil
                keysSet.remove(evacuatedKey)
                linkedList?.next?.prev = nil
                linkedList = linkedList?.next
                linkedListTail?.next = headNode
                headNode.prev = linkedListTail
                headNode.next = nil
                linkedListTail = headNode
                result = false
            }
        }
        keysSet.insert(key)
        map[key] = value
        return result
    }

    func dictionary() -> [String : String] {
        var result = [String : String]()
        for key in keysSet {
            guard let value = get(valueForKey: key) else {
                continue
            }
            result[key] = value
        }
        return result
    }
}
