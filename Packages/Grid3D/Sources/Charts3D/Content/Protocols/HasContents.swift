//
// Created by John Griffin on 4/5/24
//

import Foundation
import Spatial

public protocol HasContents: Bounded {
    func contentsFor(_ environment: RenderEnvironment?) -> [ChartContent]
}

public extension HasContents {
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
