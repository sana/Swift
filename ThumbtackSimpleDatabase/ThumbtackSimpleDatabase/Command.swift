//
//  Command.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/5/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

private enum CommandType {
    case Unknown
    case Set
    case Get
    case Unset
    case NumEqualTo
    case End
    case Begin
    case Rollback
    case Commit
}

class Command {
    private let commandType : CommandType
    private let key : String?
    private let value : String?
    let description : String
    
    init(command: String) {
        description = command
        if (command.hasPrefix("SET")) {
            self.commandType = CommandType.Set
            let tokens = command.componentsSeparatedByString(" ")
            assert(tokens.count == 3)
            self.key = tokens[1]
            self.value = tokens[2]
        } else if (command.hasPrefix("GET")) {
            self.commandType = CommandType.Get
            let tokens = command.componentsSeparatedByString(" ")
            assert(tokens.count == 2)
            self.key = tokens[1]
            self.value = nil
        } else if (command.hasPrefix("UNSET")) {
            self.commandType = CommandType.Unset
            let tokens = command.componentsSeparatedByString(" ")
            assert(tokens.count == 2)
            self.key = tokens[1]
            self.value = nil
        } else if (command.hasPrefix("NUMEQUALTO")) {
            self.commandType = CommandType.NumEqualTo
            let tokens = command.componentsSeparatedByString(" ")
            assert(tokens.count == 2)
            self.key = tokens[1]
            self.value = nil
        } else if (command == "END") {
            self.commandType = CommandType.End
            self.key = nil
            self.value = nil
        } else if (command == "BEGIN") {
            self.commandType = CommandType.Begin
            self.key = nil
            self.value = nil
        } else if (command == "ROLLBACK") {
            self.commandType = CommandType.Rollback
            self.key = nil
            self.value = nil
        } else if (command == "COMMIT") {
            self.commandType = CommandType.Commit
            self.key = nil
            self.value = nil
        } else {
            self.commandType = CommandType.Unknown
            self.key = nil
            self.value = nil
        }
        assert(self.commandType != CommandType.Unknown)
    }
    
    func getKey() -> String {
        return self.key!
    }
    
    func getValue() -> String {
        return self.value!
    }
    
    func isSet() -> Bool {
        return self.commandType == CommandType.Set
    }
    
    func isGet() -> Bool {
        return self.commandType == CommandType.Get
    }
    
    func isUnset() -> Bool {
        return self.commandType == CommandType.Unset
    }
    
    func isEnd() -> Bool {
        return self.commandType == CommandType.End
    }
    
    func isNumEqualTo() -> Bool {
        return self.commandType == CommandType.NumEqualTo
    }
    
    func isBegin() -> Bool {
        return self.commandType == CommandType.Begin
    }

    func isRollback() -> Bool {
        return self.commandType == CommandType.Rollback
    }

    func isCommit() -> Bool {
        return self.commandType == CommandType.Commit
    }
}
