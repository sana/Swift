//
//  Pair.swift
//  CommonMarkSwift
//
//  Created by Laurentiu Dascalu on 3/2/19.
//

import Foundation

struct Pair<U, V> {
    let first: U
    let second: V
}

extension Pair : Equatable, Hashable where U : Hashable, V : Hashable {
    static func ==(lhs: Pair, rhs: Pair) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
    }
}
