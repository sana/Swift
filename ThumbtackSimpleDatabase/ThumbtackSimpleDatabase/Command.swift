//
//  Command.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/5/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

enum Command {
    case Unknown
    case Set(key: String, value: String)
    case Get(key: String)
    case Unset(key: String)
    case NumEqualTo(value: String)
    case End
    case Begin
    case Rollback
    case Commit
}

enum Error: ErrorType {
    case MissingKey(String)
    case MissingValue(String)
    case MissingCommand(String)
    case UnexpectedCommand(String)
}

extension Command {
    init(input: String) throws {
        let tokens = input.componentsSeparatedByString(" ")
        var generator = tokens.generate() // 1
        guard let tok = generator.next()
            else { throw Error.MissingCommand(input) } // 2
        switch tok {
        case "BEGIN":
            self = Command.Begin
        case "SET":
            guard let key = generator.next()
                else { throw Error.MissingKey(input) } // 3
            guard let value = generator.next()
                else { throw Error.MissingValue(input) }
            self = Command.Set(key: key, value: value) // 4
        case "GET":
            guard let key = generator.next()
                else { throw Error.MissingKey(input) } // 3
            self = Command.Get(key: key)
        case "UNSET":
            guard let key = generator.next()
                else { throw Error.MissingKey(input) } // 3
            self = Command.Unset(key: key)
        case "NUMEQUALTO":
            guard let value = generator.next()
                else { throw Error.MissingValue(input) } // 3
            self = Command.NumEqualTo(value: value)
        case "END":
            self = Command.End
        case "ROLLBACK":
            self = Command.Rollback
        case "COMMIT":
            self = Command.Commit
        default: throw Error.UnexpectedCommand(input)
        }
    }
}
