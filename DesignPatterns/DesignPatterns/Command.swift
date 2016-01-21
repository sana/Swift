//
//  Command.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 12/23/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

typealias CompletionHandlerType = (result: Bool) -> Void

/**
 Encapsulate a request as an object, thereby letting you parameterize clients
 with different requests, queue or log requests, and support undoable 
 operations.
 */
protocol Command {
    // The completion handler is called with success or failure after trying to
    // execute the operation. If the command should be executed again, the
    // method will return false.
    func execute(completion: CompletionHandlerType) -> Bool
    
    func isUndoable() -> Bool
    
    // This is the reverse operation of execute.
    func unexecute(completion: CompletionHandlerType) -> Bool
}

class CommandType : Command, Hashable {
    func execute(completion: CompletionHandlerType) -> Bool {
        return true
    }

    func isUndoable() -> Bool {
        return false
    }
    
    func unexecute(completion: CompletionHandlerType) -> Bool {
        return true
    }

    var hashValue : Int {
        get {
            return unsafeAddressOf(self).hashValue
        }
    }
}

func ==(left: CommandType, right: CommandType) -> Bool {
    return left.hashValue == right.hashValue
}

class CommandCenter {
    private var commands: Set<CommandType>
    private var successfullyExecuteCommands: Set<CommandType>

    init() {
        commands = Set<CommandType>()
        successfullyExecuteCommands = Set<CommandType>()
    }
    
    func addCommand(command: CommandType) -> Bool {
        if (commands.contains(command)) {
            return false
        }
        commands.insert(command)
        return true
    }
    
    func removeCommand(command: CommandType) -> Bool {
        if (!commands.contains(command)) {
            return false
        }
        commands.remove(command)
        return true
    }
    
    func execute(completion: CompletionHandlerType) -> Bool {
        var result = true
        for command in commands {
            if (command.execute(completion)) {
                successfullyExecuteCommands.insert(command)
            } else {
                result = false
            }
        }
        return result
    }
    
    func unexecute(completion: CompletionHandlerType) -> Bool {
        for command in successfullyExecuteCommands.reverse() {
            if (command.isUndoable()) {
                if (!command.unexecute(completion)) {
                    return false
                }
            }
        }
        return true
    }

    func commit() -> Bool {
        if (successfullyExecuteCommands == commands) {
            clear()
            return true
        }
        return false
    }
    
    func clear() {
        commands.removeAll()
        successfullyExecuteCommands.removeAll()
    }
    
    func outstandingCommands() -> Set<CommandType> {
        return commands
    }
}
