//
// Created by John Griffin on 4/21/24
//

import RealityUI
import Spatial

public struct Chart3D: RealityContent, BuiltIn {
    var contents: ChartContents

    public func customSizeFor(_: RealityUI.ProposedSize3D) -> Size3D {
        .zero
    }

    public func customRender(_: RealityUI.RenderContext, size _: Size3D) -> RenderNode {
        EmptyEntity()
            .asNode()
    }
}
