//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct RealityFrame<Content: RealityView>: RealityView, BuiltIn {
    var width: Double?
    var height: Double?
    var depth: Double?
    var alignment: Alignment3D
    var content: Content

    private func newProposedSize(_ proposed: ProposedSize) -> ProposedSize {
        .init(
            width: width ?? proposed.width,
            height: height ?? proposed.height,
            depth: depth ?? proposed.depth
        )
    }

    public func sizeFor(_ proposed: ProposedSize) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeFor(newProposed)

        return .init(
            width: width ?? childSize.width,
            height: height ?? childSize.height,
            depth: depth ?? childSize.depth
        )
    }

    public func render(_ context: RenderContext, size: Size3D) -> RenderNode {
        let newProposed = newProposedSize(size)
        let childSize = content.sizeFor(newProposed)

        let selfPoint = alignment.point(for: newProposed)
        let childPoint = alignment.point(for: childSize)
        let offset = selfPoint - childPoint
        let pose = Pose3D(position: Point3D(offset), rotation: .identity)

        let childNode = content.render(context, size: size)
        return RenderNode(
            renderer: PoseEntityRenderer(pose: pose),
            children: [childNode]
        )
    }
}
