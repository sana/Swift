import Ccmark

public extension String {
    public func markDownToHTML() -> String? {
        guard let outString = cmark_markdown_to_html(self, self.utf8.count, 0) else {
            return nil
        }
        defer {
            free(outString)
        }
        return String(cString: outString)
    }
}

let markdown = "*Hello world!*"
if let markdownHTML = markdown.markDownToHTML() {
    print("OK \(markdownHTML)")
}
