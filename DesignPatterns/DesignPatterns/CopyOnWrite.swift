//
//  CopyOnWrite.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 7/8/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import AppKit

struct BezierPath {
    private var _bezierPath =  NSBezierPath()

    var pathForReading: NSBezierPath {
        return _bezierPath
    }

    var pathForWriting: NSBezierPath {
        mutating get {
            _bezierPath = (_bezierPath.copy() as? NSBezierPath) ?? NSBezierPath()
            return _bezierPath
        }
    }

    var isEmpty: Bool {
        return pathForReading.isEmpty
    }

    mutating func addLineToPoint(point: CGPoint) {
        var tmpPoint = point
        pathForWriting.appendPoints(&tmpPoint, count: 1)
    }
}
