//
// Created by John Griffin on 4/18/24
//

import Foundation

@resultBuilder
public enum RealityBuilder {
    public static func buildBlock() -> EmptyContent {
        EmptyContent()
    }

    public static func buildBlock<Content: RealityContent>(_ content: Content) -> Content {
        content
    }

    public static func buildBlock<each Content: RealityContent>(
        _ content: repeat each Content
    ) -> RealityTuple< repeat each Content> {
        RealityTuple(repeat each content)
    }

    public static func buildExpression<Content: RealityContent>(_ expression: Content) -> Content {
        expression
    }

    public static func buildEither<Content: RealityContent>(first component: Content) -> Content {
        component
    }

    public static func buildEither<Content: RealityContent>(second component: Content) -> Content {
        component
    }

    public static func buildIf<Content: RealityContent>(_ content: Content?) -> Content? {
        content
    }
}

public extension RealityBuilder {
    static func build(@RealityBuilder build: () -> some RealityContent) -> some RealityContent {
        build()
    }
}
