//
//  CommandTests.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

class IncrementCommand : CommandType, PrintableClass {
    typealias CommandStateType = Int
    var state: Int
    
    init(state: Int) {
        self.state = state
    }
    
    override func execute(completion: CompletionHandlerType) -> Bool {
        self.state++
        completion(result: true)
        return true
    }
    
    override func isUndoable() -> Bool {
        return true
    }
    
    override func unexecute(completion: CompletionHandlerType) -> Bool {
        self.state--
        completion(result: true)
        return true
    }
    
    func stringValue() -> String {
        return "\( NSStringFromClass(self.dynamicType) ) \( state )"
    }
}

class DecrementCommand : CommandType, PrintableClass {
    typealias CommandStateType = Int
    var state: Int
    
    init(state: Int) {
        self.state = state
    }
    
    override func execute(completion: CompletionHandlerType) -> Bool {
        self.state--
        completion(result: true)
        return true
    }
    
    override func isUndoable() -> Bool {
        return true
    }
    
    override func unexecute(completion: CompletionHandlerType) -> Bool {
        self.state++
        completion(result: true)
        return true
    }
    
    func stringValue() -> String {
        return "\( NSStringFromClass(self.dynamicType) ) \( state )"
    }
}

class WriteDataToServerCommand : CommandType, PrintableClass {
    typealias CommandStateType = String
    var state: String
    
    init(state: String) {
        self.state = state
    }
    
    override func execute(completion: CompletionHandlerType) -> Bool {
        print(self)
        completion(result: true)
        return true
    }

    func stringValue() -> String {
        return "\( NSStringFromClass(self.dynamicType) ) \( state )"
    }
}

class FaultyCommand : CommandType {
    typealias CommandStateType = AnyObject
    
    override init() { }

    override func execute(completion: CompletionHandlerType) -> Bool {
        completion(result: false)
        return false
    }
}

func emptyCompletionHandler(result: Bool) -> Void { }

class CommandTests : SampleTest {
    class func testWriteDataToServerCommand() {
        let commandCenter: CommandCenter = CommandCenter()
        commandCenter.addCommand(WriteDataToServerCommand(state: "hi"))
        commandCenter.addCommand(WriteDataToServerCommand(state: "there"))
        commandCenter.addCommand(WriteDataToServerCommand(state: "cutie"))
        print("Executing commands .... \( commandCenter.execute(emptyCompletionHandler) )")
        print("Commiting commands .... \( commandCenter.commit() )")
        print("Outstanding commands .... \( commandCenter.outstandingCommands() )")
    }
    
    class func testFaultyCommand() {
        let commandCenter: CommandCenter = CommandCenter()
        commandCenter.addCommand(WriteDataToServerCommand(state: "oooops"))
        commandCenter.addCommand(FaultyCommand())
        commandCenter.addCommand(WriteDataToServerCommand(state: "I did it again"))
        print("Executing commands .... \( commandCenter.execute(emptyCompletionHandler) )")
        print("Commiting commands .... \( commandCenter.commit() )")
        print("Outstanding commands .... \( commandCenter.outstandingCommands() )")
        commandCenter.clear()
        
    }
    
    class func testUndo() {
        let commandCenter: CommandCenter = CommandCenter()
        commandCenter.addCommand(IncrementCommand(state: 5))
        commandCenter.addCommand(FaultyCommand())
        commandCenter.addCommand(DecrementCommand(state: 100))
        print("Outstanding commands .... \( commandCenter.outstandingCommands() )")
        print("Executing commands .... \( commandCenter.execute(emptyCompletionHandler) )")
        print("Commiting commands .... \( commandCenter.commit() )")
        print("Outstanding commands .... \( commandCenter.outstandingCommands() )")
        print("Unexecute commands .... \( commandCenter.unexecute(emptyCompletionHandler) )")
        print("Outstanding commands .... \( commandCenter.outstandingCommands() )")
        commandCenter.clear()
    }
    
    class func runSamples() {
        testWriteDataToServerCommand()
        testFaultyCommand()
        testUndo()
    }
}