//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public struct Chart3D: ChartContent, EntityRepresentable, Posed {
    public var boundsToInclude: [Point3D]?
    public var contentsPadding: Size3D

    public var contents: [ChartContent]
    public var contentsBounds: Rect3D?

    public var position: Point3D = .zero
    public var rotation: Rotation3D?

    public init(
        boundsToInclude: [Point3D]? = nil,
        contentsPadding: Size3D = .zero,
        @ChartBuilder contents: () -> [ChartContent]
    ) {
        self.boundsToInclude = boundsToInclude
        self.contentsPadding = contentsPadding

        self.contents = contents()
        contentsBounds = boundsOfContents()
    }
}

public extension Chart3D {
    var chartBounds: Rect3D {
        var b: Rect3D?

        if let boundsToInclude, !boundsToInclude.isEmpty {
            b = Rect3D(points: boundsToInclude)
        }

        if let contentsBounds {
            let paddedContentBounds = contentsBounds.inset(by: -contentsPadding)
            b = b?.union(paddedContentBounds) ?? paddedContentBounds
        }
        return b ?? Size3D.one.asCenterRect
    }

    // MARK: - Bounded

    var bounds: Rect3D? { chartBounds }
    var containedBounds: Rect3D? { chartBounds }
    var anchor: BoundsAnchor? { .center }

    // MARK: - ContentContaining

    @ChartBuilder
    func contentsFor(_: RenderEnvironment?) -> [ChartContent] {
        contents
        BoundingBox(chartBounds)
    }

    func makeEntity() throws -> Entity {
        Entity()
    }

    // MARK: - modifiers

    func withBoundsToInclude(_ points: [Point3D]) -> Self {
        modify(self) { $0.boundsToInclude = points }
    }

    func withContentsPadding(_ padding: Size3D) -> Self {
        modify(self) { $0.contentsPadding = padding }
    }
}
