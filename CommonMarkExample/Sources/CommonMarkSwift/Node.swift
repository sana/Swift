//
//  Node.swift
//  CommonMarkSwift
//
//  Created by Laurentiu Dascalu on 3/2/19.
//

import Foundation
import Ccmark

public class Node {
    private let node: OpaquePointer

    public init?(type: cmark_node_type) {
        guard let node = cmark_node_new(type) else {
            return nil
        }
        self.node = node
    }

    public init(node: OpaquePointer) {
        self.node = node
    }

    public init?(markdown: String) {
        guard let node = cmark_parse_document(markdown, markdown.utf8.count, 0) else {
            return nil
        }
        self.node = node
    }

    fileprivate var type: cmark_node_type {
        return cmark_node_get_type(node)
    }

    public var title: String? {
        get {
            guard let cString = cmark_node_get_title(node) else {
                return nil
            }
            return String(cString: cString)
        }
        set {
            cmark_node_set_title(node, newValue?.cString(using: .utf8))
        }
    }

    public var urlString: String? {
        get {
            guard let cString = cmark_node_get_url(node) else {
                return nil
            }
            return String(cString: cString)
        }
        set {
            cmark_node_set_url(node, newValue?.cString(using: .utf8))
        }
    }

    public var literal: String? {
        get {
            guard let cString = cmark_node_get_literal(node) else {
                return nil
            }
            return String(cString: cString)
        }
        set {
            cmark_node_set_literal(node, newValue?.cString(using: .utf8))
        }
    }

    public var listType: cmark_list_type {
        get {
            return cmark_node_get_list_type(node)
        }
        set {
            cmark_node_set_list_type(node, newValue)
        }
    }

    public var children: [Node] {
        var result = [Node]()
        var iterator = cmark_node_first_child(node)
        while let unwrappedIterator = iterator {
            result.append(Node(node: unwrappedIterator))
            iterator = cmark_node_next(unwrappedIterator)
        }
        return result
    }

    deinit {
        let type = cmark_node_get_type(node)
        guard type == CMARK_NODE_DOCUMENT else {
            return
        }
        cmark_node_free(node)
    }
}

extension Node : Equatable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.node == rhs.node
    }
}

public extension Inline {
    init?(node: Node) {
        let inlineChildren = {
            node.children.compactMap(Inline.init)
        }
        switch node.type {
        case CMARK_NODE_TEXT:
            guard let inlineText = node.literal.map( { Inline.text(text: $0) } ) else {
                return nil
            }
            self = inlineText
        case CMARK_NODE_SOFTBREAK:
            self = .softBreak
        case CMARK_NODE_LINEBREAK:
            self = .lineBreak
        case CMARK_NODE_CODE:
            guard let inlineCode = node.literal.map( { Inline.code(text: $0) } ) else {
                return nil
            }
            self = inlineCode
        case CMARK_NODE_HTML_INLINE:
            guard let inlineHtml = node.literal.map( { Inline.html(text: $0) } ) else {
                return nil
            }
            self = inlineHtml
        case CMARK_NODE_CUSTOM_INLINE:
            guard let inlineCustom = node.literal.map( { Inline.custom(literal: $0) } ) else {
                return nil
            }
            self = inlineCustom
        case CMARK_NODE_EMPH:
            self = .emphasis(children: inlineChildren())
        case CMARK_NODE_STRONG:
            self = .strong(children: inlineChildren())
        case CMARK_NODE_LINK:
            self = .link(children: inlineChildren(), title: node.title, url: node.urlString)
        case CMARK_NODE_IMAGE:
            self = .image(children: inlineChildren(), title: node.title, url: node.urlString)
        case CMARK_NODE_FIRST_INLINE:
            self = .firstInline
        case CMARK_NODE_LAST_INLINE:
            self = .lastInline
        default:
            return nil
        }
    }
}

public extension ListType {
    init?(node: Node) {
        switch node.listType {
        case CMARK_BULLET_LIST:
            self = .unordered
        case CMARK_ORDERED_LIST:
            self = .ordered
        case CMARK_NO_LIST:
            return nil
        default:
            return nil
        }
    }
}
