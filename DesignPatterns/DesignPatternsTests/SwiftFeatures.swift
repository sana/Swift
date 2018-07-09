//
//  SwiftFeatures.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/8/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class SwiftFeaturesTests : XCTestCase {
    func testString() {
        var tokens = [String]()
        let values = "one,two,three,four"
        var i = values.startIndex
        while let comma = values[i..<values.endIndex].index(of: ",") {
            tokens.append(String(values[i..<comma]))
            i = values.index(after: comma)
        }
        if i != values.endIndex {
            tokens.append(String(values[i..<values.endIndex]))
        }
        XCTAssertEqual(tokens, ["one", "two", "three", "four"])
    }
}
