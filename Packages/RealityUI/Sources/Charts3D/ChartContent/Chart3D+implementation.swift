//
// Created by John Griffin on 4/21/24
//

import RealityUI
import Spatial

public extension Chart3D {
    // MARK: - CustomChartContent

    func customPlottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    func customRender(_: ChartEnvironment) -> any RealityContent {
        content.render(.init())
    }
}

public extension Chart3D {
    // MARK: - RealityContent

    func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    func customRender(_ context: RenderContext, size: Size3D) -> RealityRenderNode {
        customRender(ChartEnvironment()).render(context, size: size)
    }
}
