//
// Created by John Griffin on 4/21/24
//

import Foundation

public protocol ChartContent {
    associatedtype Body: ChartContent
    var body: Body { get }
}

public typealias ChartRenderNode = Void

public extension ChartContent {
    func dimensionDomains() -> DimensionDomains {
        if let mark = self as? ChartBuiltIn {
            mark.customDimensionDomains()
        } else {
            body.dimensionDomains()
        }
    }

    func render() -> ChartRenderNode {
        if let builtIn = self as? ChartBuiltIn {
            builtIn.customRender()
        } else {
            body.render()
        }
    }
}

// MARK: - BuiltIn

public protocol ChartBuiltIn {
    typealias Body = Never

    func customDimensionDomains() -> DimensionDomains

    func customRender() -> ChartRenderNode
}

public extension ChartContent where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: ChartContent {
    public typealias Body = Never
}

// MARK: - EmptyChartContent

public struct EmptyChartContent: ChartContent, ChartBuiltIn {
    public init() {}

    public func customDimensionDomains() -> DimensionDomains { .init() }

    public func customRender() {}
}

// MARK: -

public struct ChartTuple: ChartContent, ChartBuiltIn {
    public let contents: [any ChartContent]

    public init(contents: [any ChartContent]) {
        self.contents = contents
    }

    public func customDimensionDomains() -> DimensionDomains {
        contents
            .map { $0.dimensionDomains() }
            .reduce(into: DimensionDomains()) { result, next in result.merge(next) }
    }

    public func customRender() {}
}
