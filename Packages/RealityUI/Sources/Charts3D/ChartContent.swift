//
// Created by John Griffin on 4/21/24
//

import RealityUI

public protocol ChartContent {
    associatedtype ChartBody: ChartContent
    var chartBody: ChartBody { get }
}

public extension ChartContent {
    func dimensionDomains() -> DimensionDomains {
        if let mark = self as? ChartBuiltIn {
            mark.customDimensionDomains()
        } else {
            chartBody.dimensionDomains()
        }
    }

    func render(in environment: RealityEnvironment) -> RealityRenderNode {
        if let builtIn = self as? ChartBuiltIn {
            builtIn.customRender(in: environment)
        } else {
            chartBody.render(in: environment)
        }
    }
}

// MARK: - BuiltIn

public protocol ChartBuiltIn {
    typealias Content = Never

    func customDimensionDomains() -> DimensionDomains

    func customRender(in environement: RealityEnvironment) -> RealityRenderNode
}

public extension ChartContent where ChartBody == Never {
    var chartBody: Never { fatalError("This should never be called.") }
}

extension Never: ChartContent {
    public typealias ChartBody = Never
}

// MARK: - EmptyChartContent

public struct EmptyChartContent: ChartContent, ChartBuiltIn {
    public init() {}

    public func customDimensionDomains() -> DimensionDomains { .init() }

    public func customRender(in _: RealityEnvironment) -> RealityRenderNode {
        EmptyEntity().asNode()
    }
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

    public func customRender(in _: RealityEnvironment) -> RealityRenderNode {
        EmptyEntity().asNode()
    }
}
