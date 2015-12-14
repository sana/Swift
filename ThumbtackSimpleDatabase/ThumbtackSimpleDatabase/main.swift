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

class KeyboardInput: GeneratorType {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let prompt: String?
    
    init(prompt: String? = nil) {
        self.prompt = prompt
    }
    
    func next() -> String? {
        if let prompt = prompt { print(prompt, terminator: "") }
        guard let input = String(data: keyboard.availableData, encoding: NSUTF8StringEncoding)
            else { return nil }
        return String(input.characters.dropLast())
    }
}

let runTestsFromCommandLine = false
var trie: Trie = Trie()

func handle(command: Command) -> Bool {
    var result: Bool = true
    switch command {
    case let .Set(key, value):
        trie.put(key, value: value)
    case let .Get(value):
        print(trie.get(value) ?? "NULL")
    case let .NumEqualTo(value):
        print((trie.getAllValuesFor(value) ?? []).count)
    case let .Unset(key):
        trie.remove(key)
    case .End:
        result = false
        break
    case .Begin:
        trie.begin()
    case .Rollback:
        if (!trie.rollback()) {
            print("NO TRANSACTION")
        }
    case .Commit:
        if (!trie.commit()) {
            print("NO TRANSACTION")
        }
    default:
        result = false
        break
    }
    return result
}

if (runTestsFromCommandLine) {
    let keyboard = KeyboardInput(prompt: "> ")
    while let input = keyboard.next() {
        do {
            let command = try Command(input: input)
            if (!handle(command)) {
                break
            }
        } catch {
            print(error)
        }
    }
}

func getCommandsListFromFile(fileName: String) -> [String]? {
    trie = Trie() // always start the test with a new Trie
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
    print("Running \(testName)")
    getCommandsListFromFile(testName)?
        .map({ commandString in
            do {
                return try Command.init(input: commandString)
            } catch {
                return Command.Unknown
            }
        })
        .forEach({ command in
            handle(command)
        })
    print("Done")
}

if (!runTestsFromCommandLine) {
    test("Test1")
    test("Test2")
    test("Test3")

    test("TestTransactions1")
    test("TestTransactions2")
    test("TestTransactions3")
    test("TestTransactions4")
}
