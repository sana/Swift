//
//  NodeTests.swift
//  CommonMarkSwiftTests
//
//  Created by Laurentiu Dascalu on 3/2/19.
//

import Foundation
import CommonMarkSwift
import XCTest
import Ccmark

final class NodeTests: XCTestCase {
    func testNodeProperties() throws {
        let node = try Node(type: CMARK_NODE_LINK).required()

        // Title
        XCTAssertEqual(node.title, "")
        node.title = "title"
        XCTAssertEqual(node.title, "title")
        node.title = nil
        XCTAssertEqual(node.title, "")

        // URL string
        XCTAssertEqual(node.urlString, "")
        node.urlString = "urlString"
        XCTAssertEqual(node.urlString, "urlString")
        node.urlString = nil
        XCTAssertEqual(node.urlString, "")

        // Literal
        XCTAssertEqual(node.literal, nil)
        node.literal = "literal"
        XCTAssertEqual(node.literal, nil)

        // List type
        XCTAssertNil(ListType(node: node))

        // Children
        let emptyArray = [Node]()
        XCTAssertEqual(node.children, emptyArray)
    }
}
