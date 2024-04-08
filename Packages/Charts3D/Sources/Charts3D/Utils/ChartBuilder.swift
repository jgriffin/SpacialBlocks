//
// Created by John Griffin on 4/5/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public typealias Expression = ChartContent
    public typealias Component = [ChartContent]
    public typealias FinalResult = [ChartContent]

    public static func buildBlock(_ components: Component...) -> Component {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    public static func buildExpression(_ expressions: [ChartContent]) -> Component {
        expressions
    }

    public static func buildOptional(_ component: Component?) -> Component {
        component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        component
    }

    public static func buildEither(second component: Component) -> Component {
        component
    }

    public static func buildArray(_ components: [Component]) -> Component {
        components.flatMap { $0 }
    }
}

let test = Chart3D {
    Box3D()
    for i in 0 ..< 3 {
        Box3D()
    }
}
