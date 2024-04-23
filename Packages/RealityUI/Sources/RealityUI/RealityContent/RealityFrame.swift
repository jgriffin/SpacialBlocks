//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct RealityFrame<Content: RealityContent>: RealityContent, BuiltIn {
    var content: Content
    var width: Double?
    var height: Double?
    var depth: Double?
    var alignment: Alignment3D

    private func newProposedSize(_ proposed: ProposedSize3D) -> ProposedSize3D {
        .init(
            width: width ?? proposed.width,
            height: height ?? proposed.height,
            depth: depth ?? proposed.depth
        )
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeThatFits(newProposed)

        return .init(
            width: width ?? childSize.width,
            height: height ?? childSize.height,
            depth: depth ?? childSize.depth
        )
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> RealityRenderNode {
        let proposed = newProposedSize(.init(size))
        let childSize = content.sizeThatFits(proposed)

        return content.render(context, size: size)
            .wrappedInAlignment(alignment, parent: proposed.sizeOrDefault, child: childSize)
    }
}
