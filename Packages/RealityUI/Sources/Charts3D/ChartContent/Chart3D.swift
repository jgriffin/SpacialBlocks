//
// Created by John Griffin on 4/21/24
//

import RealityUI
import Spatial

public struct Chart3D<Content: ChartContent>: ChartContent, ChartCustomContent, RealityContent, BuiltIn {
    public var content: Content

    public init(@ChartBuilder content: () -> Content) {
        self.content = content()
    }

    public func customDimensionDomains() -> DimensionDomains {
        content.dimensionDomains()
    }

    public func customRender(_: ChartEnvironment) -> any RealityContent {
        content.render(.init())
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> RealityRenderNode {
        customRender(ChartEnvironment()).render(context, size: size)
    }
}
