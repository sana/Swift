//
//  Array+Additions.swift
//  ThumbtackSimpleDatabase
//
//  Created by Laurentiu Dascalu on 12/6/15.
//  Copyright © 2015 Laurentiu Dascalu. All rights reserved.
//

import Foundation

extension Array where Element : Equatable
{
    mutating func remove(object: Element) -> Bool
    {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
            return true
        }
        return false
    }
}
