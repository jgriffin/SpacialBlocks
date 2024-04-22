//
// Created by John Griffin on 4/21/24
//

import Spatial

public struct RealityOffset<Content: RealityContent>: RealityContent, BuiltIn {
    var content: Content
    var offset: Vector3D

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        content.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> RenderNode {
        content.render(context, size: size)
            .wrappedInTranslation(offset)
    }
}