//
// Created by John Griffin on 4/20/24
//

import Spatial

public struct RealityAspectRatio<Content: RealityContent>: RealityContent, BuiltIn {
    var content: Content
    var aspectRatio: Size3D?
    var maxScale: Double?
    var contentMode: ContentMode

    public init(
        content: Content,
        aspectRatio: Size3D?,
        maxScale: Double?,
        contentMode: ContentMode
    ) {
        self.content = content
        self.aspectRatio = aspectRatio
        self.maxScale = maxScale
        self.contentMode = contentMode
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        let proposal = aspectRatio.map {
            let proposalSize = AspectRatioMath.scaledToFit(
                proposed.sizeOrInfinite,
                aspectRatio: $0,
                maxScale: nil
            )
            return ProposedSize3D(proposalSize)
        } ?? proposed

        let childSize = content.sizeThatFits(proposal)

        return AspectRatioMath.scaledToFit(
            childSize,
            into: proposed.sizeOrInfinite,
            maxScale: 1
        )
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> RealityRenderNode {
        let childSize = content.sizeThatFits(.init(size))
        let scale = AspectRatioMath.scaleToFit(childSize, into: size)
        let scaleSize = Size3D.one * min(scale, maxScale ?? .greatestFiniteMagnitude)

        return content.render(context, size: childSize)
            .wrappedInTransform(AffineTransform3D(scale: scaleSize))
    }
}
