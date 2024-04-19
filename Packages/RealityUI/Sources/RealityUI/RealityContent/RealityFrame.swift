//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct RealityFrame<Content: RealityContent>: RealityContent, BuiltIn {
    var width: Double?
    var height: Double?
    var depth: Double?
    var alignment: Alignment3D
    var content: Content

    private func newProposedSize(_ proposed: ProposedSize3D) -> ProposedSize3D {
        .init(
            width: width ?? proposed.width,
            height: height ?? proposed.height,
            depth: depth ?? proposed.depth
        )
    }

    public func sizeFor(_ proposed: ProposedSize3D) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeThatFits(newProposed)

        return .init(
            width: width ?? childSize.width,
            height: height ?? childSize.height,
            depth: depth ?? childSize.depth
        )
    }

    public func render(_ context: RenderContext, size: Size3D) -> RenderNode {
        let proposed = newProposedSize(.init(size: size))
        let childSize = content.sizeThatFits(proposed)

        let selfPoint = alignment.point(for: proposed.orDefault)
        let childPoint = alignment.point(for: childSize)
        let pose = Pose3D(position: Point3D(selfPoint - childPoint), rotation: .identity)

        let childNode = content.render(context, size: size)
        return RenderNode(
            PoseEntityRenderer(pose: pose),
            children: [childNode]
        )
    }
}
