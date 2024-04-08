//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - Chart3DEntity

public protocol ChartContent {
    typealias ContentID = UUID

    // MARK: - bounds

    var bounds: Rect3D? { get }
    var containedBounds: Rect3D? { get }

    // bounds in the parent coordinates by applying (position/rotation) to bounds
    // comes from Posed or NotPosed
    var frame: Rect3D? { get }
    var containedFrame: Rect3D? { get }

    // MARK: - contentsFor

    func contentsFor(_ environment: RenderEnvironment?) -> [ChartContent]
}

public extension ChartContent {
    // MARK: position

    func contentsFor(_: RenderEnvironment?) -> [ChartContent] { [] }

    // MARK: - Bounded

    var containedBounds: Rect3D? {
        guard let contained = boundsOfContents() else {
            return bounds
        }
        return bounds?.union(contained) ?? contained
    }

    func boundsOfContents() -> Rect3D? {
        Rect3D.union(contentsFor(nil).compactMap(\.containedFrame))
    }
}

public extension ChartContent {}
