import CommonMarkSwift
import XCTest
import class Foundation.Bundle

final class CommonMarkExampleTests: XCTestCase {
    func testExample() throws {
        let markdown = "*Hello world!*"
        guard let markdownHTML = markdown.markDownToHTML() else {
            XCTFail()
            return
        }
        XCTAssertEqual(markdownHTML, "<p><em>Hello world!</em></p>\n")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
