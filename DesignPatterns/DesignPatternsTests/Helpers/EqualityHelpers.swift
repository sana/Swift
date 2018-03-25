//
//  EqualityHelpers.swift
//  DesignPatterns
//
//  Created by Laurentiu Dascalu on 4/4/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import Foundation

func == <T:Equatable> (lhs: (T, T), rhs: (T, T)) -> Bool
{
    return (lhs.0 == rhs.0) && (lhs.1 == rhs.1)
}
