//
// Created by John Griffin on 4/19/24
//

import Spatial

public struct StackedLayout: RealityLayout {
    public var alignment: Alignment3D
    public var axis: Vector3D

    public init(alignment: Alignment3D, axis: Vector3D) {
        self.alignment = alignment
        self.axis = axis
    }

    public func sizeThatFits(contents: [any RealityContent], proposal: ProposedSize3D) -> Size3D {
        guard !contents.isEmpty else { return .zero }

        let resolved = proposal.sizeOrInfinite
        let firstProposal = StackMath.initialChildProposalFrom(
            resolved,
            axis: axis,
            contentCount: contents.count
        )

        let proposed = ProposedSize3D(firstProposal)
        let sizes = contents.map { $0.sizeThatFits(proposed) }

        return StackMath.sizeFromFits(sizes, axis: axis)
    }

    public func placeContents(contents: [any RealityContent], in size: Size3D) -> [LayoutContentPlacement] {
        guard !contents.isEmpty else { return [] }

        let firstProposal = StackMath.initialChildProposalFrom(
            size,
            axis: axis,
            contentCount: contents.count
        )

        let proposed = ProposedSize3D(firstProposal)
        let fitSizes = contents.map { $0.sizeThatFits(proposed) }
        let centerOffsets = StackMath.centerOffsetsFromStackCenter(fitSizes: fitSizes, spacing: .zero)

        let placements = zip(contents, zip(fitSizes, centerOffsets))
            .map { content, sp in
                let alignmentOffset = alignment.offset(parent: size, child: sp.0)
                let position = StackMath.mixVectors(
                    axis: axis,
                    onAxis: sp.1,
                    offAxis: alignmentOffset
                )
                return LayoutContentPlacement(
                    content: content,
                    size: sp.0,
                    position: Point3D(position)
                )
            }
        return placements
    }
}
