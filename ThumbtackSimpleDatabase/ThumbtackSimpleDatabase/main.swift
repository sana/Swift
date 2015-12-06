//
//  main.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/4/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

func testTransactionImplementation() {
    let trie = Trie()

    trie.put("key", value: "value")
    trie.put("country", value: "USA")
    trie.put("key", value: "haha")
    trie.put("twitter", value: "interesting")
    trie.put("thumbtack", value: "interesting")

    print(trie.description())
    print("==============")

    trie.begin()
    trie.put("country", value: "RO")
    trie.put("key", value: "xoxo")
    
    print(trie.description())
    
}

func getCommandsListFromFile(fileName: String) -> [String]? {
    do {
        let bundle = NSBundle.mainBundle()
        let myFilePath = bundle.pathForResource(fileName, ofType: "strings")
        if (myFilePath != nil) {
            return try NSString(contentsOfFile: myFilePath!, encoding: NSUTF8StringEncoding).componentsSeparatedByString("\n") as [String]
        }
    } catch {
    }
    return nil
    
}

func test(testName: String) {
    print("Running ".stringByAppendingString(testName))
    let trie = Trie()
    let commands: [String]? = getCommandsListFromFile(testName)
    if (commands != nil) {
        for command in commands! {
            let cmd : Command = Command(command: command)
            if (cmd.isSet()) {
                trie.put(cmd.getKey(), value: cmd.getValue())
            } else if (cmd.isGet()) {
                let value : String? = trie.get(cmd.getKey())
                if (value != nil) {
                    print(value!)
                } else {
                    print("NULL")
                }
            } else if (cmd.isNumEqualTo()) {
                let value = trie.getAllValuesFor(cmd.getKey())?.count
                if (value != nil) {
                    print(value!)
                } else {
                    print("0")
                }
            } else if (cmd.isUnset()) {
                trie.remove(cmd.getKey())
            } else if (cmd.isEnd()) {
                break
            } else if (cmd.isBegin()) {
                trie.begin()
            } else if (cmd.isRollback()) {
                if (!trie.rollback()) {
                    print("NO TRANSACTION")
                }
            } else if (cmd.isCommit()) {
                if (!trie.commit()) {
                    print("NO TRANSACTION")
                }
            } else {
                print(cmd.description)
                assert(false)
            }
        }
    }
    print("Done")
}

test("Test1")
test("Test2")
test("Test3")

test("TestTransactions1")
test("TestTransactions2")
test("TestTransactions3")
test("TestTransactions4")