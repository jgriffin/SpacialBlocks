//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct ChartTupleContent: ChartContent, ChartCustomContent {
    public let contents: [any ChartContent]

    public init(contents: [any ChartContent]) {
        self.contents = contents
    }

    public func customDimensionDomains() -> DimensionDomains {
        contents
            .map { $0.dimensionDomains() }
            .reduce(into: DimensionDomains()) { result, next in result.merge(next) }
    }

    public func customRender(_ env: ChartEnvironment) -> any RealityContent {
        RealityStack(layout: CanvasLayout()) {
            contents.map {
                $0.render(env)
            }
        }
    }
}
