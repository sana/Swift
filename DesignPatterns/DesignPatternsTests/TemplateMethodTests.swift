//
//  TemplateMethodTests.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 7/3/18.
//  Copyright © 2018 Laurentiu Dascalu. All rights reserved.
//

import XCTest

class DummySentenceComposer : AbstractSentenceComposer {
    func who() -> String {
        return "I"
    }

    func did() -> String {
        return "ate"
    }

    func what() -> String {
        return "a big burger"
    }
}

class SmartSentenceComposer : AbstractSentenceComposer {
    func who() -> String {
        return "Someone"
    }

    func did() -> String {
        return "studied"
    }

    func what() -> String {
        return "the design patterns book"
    }
}

class TemplateMethodTests : XCTestCase {
    func testDummySentenceComposer() {
        XCTAssertEqual(DummySentenceComposer().sentence(), "I ate a big burger")
    }

    func testSmartSentenceComposer() {
        XCTAssertEqual(SmartSentenceComposer().sentence(), "Someone studied the design patterns book")
    }
}
