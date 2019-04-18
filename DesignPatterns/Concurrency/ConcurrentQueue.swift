//
//  ConcurrentQueue.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/17/19.
//  Copyright © 2019 Laurentiu Dascalu. All rights reserved.
//

import Foundation

struct ConcurrentQueue {
    private let queue: DispatchQueue

    init(label: String) {
        queue = DispatchQueue(label: label, qos: DispatchQoS.background, attributes: [.concurrent])
    }

    func readonlyAsync(execute work: @escaping @convention(block) () -> Void) {
        queue.async {
            work()
        }
    }

    func readonlySync<T>(execute work: () throws -> T) rethrows -> T {
        return try queue.sync {
            return try work()
        }
    }

    func mutatingAsync(execute work: @escaping @convention(block) () -> Void) {
        queue.async(flags: .barrier) {
            work()
        }
    }

    func mutatingSync<T>(execute work: () throws -> T) rethrows -> T {
        return try queue.sync(flags: .barrier) {
            return try work()
        }
    }
}
