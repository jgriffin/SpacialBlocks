//
// Created by John Griffin on 4/23/24
//

import Spatial

public struct CanvasLayout: RealityLayout {
    public var alignment: Alignment3D

    public init(alignment: Alignment3D = .center) {
        self.alignment = alignment
    }

    public func sizeThatFits(contents: [any RealityContent], proposal: ProposedSize3D) -> Size3D {
        let sizes = contents.map { $0.sizeThatFits(proposal) }
        return sizes.reduce(.zero) { result, size in
            result.union(size)
        }
    }

    public func placeContents(contents: [any RealityContent], in size: Size3D) -> [LayoutContentPlacement] {
        let sizes = contents.map { $0.sizeThatFits(.init(size)) }
        return zip(contents, sizes).map { content, size -> LayoutContentPlacement in
            .init(content: content, size: size, position: .zero)
        }
    }
}
