//
// Created by John Griffin on 4/5/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public static func buildBlock(_ components: [ChartContent]...) -> [ChartContent] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ component: ChartContent) -> [ChartContent] {
        [component]
    }

    public static func buildExpression(_ components: [ChartContent]) -> [ChartContent] {
        components
    }

    public static func buildOptional(_ components: [any ChartContent]?) -> [any ChartContent] {
        components ?? []
    }

    public static func buildEither(first components: [any ChartContent]) -> [any ChartContent] {
        components
    }

    public static func buildEither(second components: [any ChartContent]) -> [any ChartContent] {
        components
    }

    public static func buildArray(_ components: [[ChartContent]]) -> [ChartContent] {
        components.flatMap { $0 }
    }
}

let test = Chart3D {
    Box3D()
    for i in 0 ..< 3 {
        Box3D()
    }
}
