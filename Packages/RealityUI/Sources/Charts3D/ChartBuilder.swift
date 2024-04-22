//
// Created by John Griffin on 4/22/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public typealias Content = any ChartContent

    public static func buildBlock(_ contents: [Content]...) -> [Content] {
        contents.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Content) -> [Content] { [expression] }

    public static func buildExpression(_ expression: [Content]) -> [Content] { expression }

    public static func buildArray(_ contents: [Content]) -> [Content] { contents }

    public static func buildEither(first content: Content) -> [Content] { [content] }

    public static func buildEither(second content: Content) -> [Content] { [content] }

    public static func buildOptional(_ contents: [Content]?) -> [Content] {
        contents ?? []
    }
}

public extension ChartBuilder {
    static func build(@ChartBuilder contents: () -> [Content]) -> [Content] {
        contents()
    }
}
