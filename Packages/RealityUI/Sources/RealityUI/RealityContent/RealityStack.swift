//
// Created by John Griffin on 4/19/24
//

import Spatial

public struct RealityStack: RealityContent, BuiltIn {
    let layout: any RealityLayout
    let contents: [any RealityContent]

    public init(
        layout: any RealityLayout,
        @RealityContentsBuilder contents: () -> [any RealityContent]
    ) {
        self.layout = layout
        self.contents = contents()
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        let size = layout.sizeThatFits(contents: contents, proposal: proposed)
        return size
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> RealityRenderNode {
        let placements = layout.placeContents(contents: contents, in: size)
        let children = placements.map { placement in
            placement.content.render(context, size: placement.size)
                .wrappedInTranslation(.init(placement.position))
        }

        return EmptyEntity(name: "Stack").asNode(children: children)
    }
}

public extension RealityStack {
    init(
        _ axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @RealityContentsBuilder contents: () -> [any RealityContent]
    ) {
        self.init(
            layout: StackedLayout(axis: axis, alignment: alignment, spacing: spacing),
            contents: contents
        )
    }
}
