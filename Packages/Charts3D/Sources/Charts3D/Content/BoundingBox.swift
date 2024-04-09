//
// Created by John Griffin on 4/8/24
//

import Foundation
import Spatial

public struct BoundingBox: ChartContent, NotPosed {
    let boundingBox: Rect3D
    let lineWidth: Float

    public init(
        _ boundingBox: Rect3D,
        lineWidth: Float = Charts.boundingBoxLineWidth
    ) {
        self.boundingBox = boundingBox
        self.lineWidth = lineWidth
    }

    public var bounds: Rect3D? { nil }
    public var containedBounds: Rect3D? { nil }

    @ChartBuilder
    public func contentsFor(_: RenderEnvironment?) -> [ChartContent] {
        Lines3D(points: bottomPoints.map(boundingBox.unitPoint),
                lineWidth: lineWidth,
                material: .boundingBoxLine)
        Lines3D(points: topPoints.map(boundingBox.unitPoint),
                lineWidth: lineWidth,
                material: .boundingBoxLine)
        posts.map { post in
            Line3D(from: boundingBox.unitPoint(post.0),
                   to: boundingBox.unitPoint(post.1),
                   lineWidth: lineWidth,
                   material: .boundingBoxLine)
        }
    }

    let bottomPoints: [Unit3D] = [
        .bottomLeadingBack, .bottomTrailingBack, .bottomTrailingFront, .bottomLeadingFront, .bottomLeadingBack,
    ]

    let topPoints: [Unit3D] = [
        .topLeadingBack, .topTrailingBack, .topTrailingFront, .topLeadingFront, .topLeadingBack,
    ]

    let posts: [(Unit3D, Unit3D)] = [
        (.bottomLeadingBack, .topLeadingBack),
        (.bottomTrailingBack, .topTrailingBack),
        (.bottomTrailingFront, .topTrailingFront),
        (.bottomLeadingFront, .topLeadingFront),
    ]
}
