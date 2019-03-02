import CommonMarkSwift
import Ccmark
import XCTest

final class CommonMarkExampleTests: XCTestCase {
    func testExample() throws {
        let markdown = "*Hello world!*"
        guard let markdownHTML = markdown.markDownToHTML() else {
            XCTFail()
            return
        }
        XCTAssertEqual(markdownHTML, "<p><em>Hello world!</em></p>\n")
    }

    func testWrapperImplementation() throws {
        let markdown = "*Hello world!*"
        let document = try cmark_parse_document(markdown, 13, CMARK_OPT_DEFAULT).required()

        let documentNode = Node(node: document)
        let visitor = CommonMarkExampleTestsVisitor()
        visitor.visit(documentNode, depth: 0)

        let expectedPair = Pair<String, Int>(first: "*Hello world!", second: 2)
        let expectedLiterals = Set([expectedPair])
        XCTAssertEqual(visitor.literals, expectedLiterals)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

// MARK:- CommonMarkExampleTestsVisitor

private class CommonMarkExampleTestsVisitor {
    var literals: Set<Pair<String, Int>>
    init() {
        literals = Set<Pair<String, Int>>()

    }

    func visit(_ node: Node, depth: Int) {
        if let literal = node.literal {
            literals.insert(Pair<String, Int>(first: literal, second: depth))
        }

        node.children.forEach { visit($0, depth: depth + 1) }
    }
}
