//
//  OptionalExtensions.swift
//  CommonMarkSwiftTests
//
//  Created by Laurentiu Dascalu on 3/2/19.
//

import Foundation

enum OptionalError : Error {
    case missingValue
}

public extension Optional {
    public func required() throws -> Wrapped {
        switch self {
        case let .some(wrapped):
            return wrapped
        default:
            throw OptionalError.missingValue
        }
    }
}
