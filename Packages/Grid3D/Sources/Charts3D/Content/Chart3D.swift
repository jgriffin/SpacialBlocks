//
// Created by John Griffin on 4/4/24
//

import Foundation
import Spatial

public struct Chart3D: ChartContent, EntityRepresentable, Anchorable, Positioned, HasContents {
    public var minBounds: Rect3D
    public var maxBounds: Rect3D?
    public var contentsPadding: Size3D

    public var contents: [ChartContent]
    public var contentsBounds: Rect3D?

    public var position: Point3D = .zero
    public var anchor: BoundsAnchor? = .center

    public init(
        minBounds: Rect3D = Charts.defaultChartMinRange,
        maxBounds: Rect3D? = nil,
        contentsPadding: Size3D = .zero,
        @ChartBuilder contents: () -> [any ChartContent]
    ) {
        self.minBounds = minBounds
        self.maxBounds = maxBounds
        self.contentsPadding = contentsPadding

        self.contents = contents()
        contentsBounds = boundsOfContents()
    }
}

public extension Chart3D {
    var chartBounds: Rect3D {
        var b = minBounds
        if let contentsBounds {
            let padded = contentsBounds.inset(by: -contentsPadding)
            b.formUnion(padded)
        }
        if let maxBounds {
            b.formIntersection(minBounds.union(maxBounds))
        }
        return b
    }

    // MARK: - Bounded

    // hides all bounds offset from above
    var bounds: Rect3D? {
        chartBounds
    }

    var containedBounds: Rect3D? {
        bounds
    }

    // MARK: - ContentContaining

    func contentsFor(_: RenderEnvironment?) -> [ChartContent] {
        contents
    }

    // MARK: - modifiers

    func withMinBounds(_ minBounds: Rect3D) -> Self {
        copy(self) { $0.minBounds = minBounds }
    }

    func withMaxBounds(_ maxBounds: Rect3D) -> Self {
        copy(self) { $0.maxBounds = maxBounds }
    }

    func withContentsPadding(_ padding: Size3D) -> Self {
        copy(self) { $0.contentsPadding = padding }
    }
}
