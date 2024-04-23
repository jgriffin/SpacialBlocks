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
        if let custom = self as? ChartCustomContent {
            custom.customDimensionDomains()
        } else {
            chartBody.dimensionDomains()
        }
    }

    func render(_ env: ChartEnvironment) -> any RealityContent {
        if let custom = self as? ChartCustomContent {
            custom.customRender(env)
        } else {
            chartBody.render(env)
        }
    }
}

// MARK: - BuiltIn

public protocol ChartCustomContent {
    typealias Content = Never

    func customDimensionDomains() -> DimensionDomains

    func customRender(_ env: ChartEnvironment) -> any RealityContent
}

public extension ChartContent where ChartBody == Never {
    var chartBody: Never { fatalError("This should never be called.") }
}

extension Never: ChartContent {
    public typealias ChartBody = Never
}

// MARK: - EmptyChartContent

public struct EmptyChartContent: ChartContent, ChartCustomContent {
    public init() {}

    public func customDimensionDomains() -> DimensionDomains { .init() }

    public func customRender(_: ChartEnvironment) -> any RealityContent {
        EmptyContent()
    }
}
