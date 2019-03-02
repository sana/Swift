//
//  Types.swift
//  CommonMarkSwift
//
//  Created by Laurentiu Dascalu on 3/2/19.
//

import Foundation
import Ccmark

public enum InlineNode {
    case text(text: String)
    case softBreak
    case lineBreak
    case code(text: String)
    case html(text: String)
    case emphasis(children: [InlineNode])
    case strong(children: [InlineNode])
    case custom(literal: String)
    case link(children: [InlineNode], title: String?, url: String?)
    case image(children: [InlineNode], title: String?, url: String?)
    case firstInline
    case lastInline
}

public enum ListType {
    case unordered
    case ordered
}

public enum BlockNode {
    case list(items: [[BlockNode]], type: ListType)
    case blockQuote(items: [BlockNode])
    case codeBlock(text: String, language: String?)
    case html(text: String)
    case paragraph(text: [InlineNode])
    case heading(text: [InlineNode], level: Int)
    case custom(literal: String)
    case thematicBreak
}
