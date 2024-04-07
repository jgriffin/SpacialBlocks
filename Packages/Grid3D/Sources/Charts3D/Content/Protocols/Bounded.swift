//
// Created by John Griffin on 4/6/24
//

import Foundation
import Spatial

public protocol Bounded {
    var bounds: Rect3D? { get }
    var containedBounds: Rect3D? { get }

    // bounds in the parent coordinates by applying (position/rotation) to bounds
    var frame: Rect3D? { get }
    var containedFrame: Rect3D? { get }
}

public extension Bounded {
    var containedBounds: Rect3D? { bounds }

    var frame: Rect3D? { bounds }
    var containedFrame: Rect3D? { bounds }
}

extension Rect3D {
    static func union(_ rects: [Rect3D]) -> Rect3D? {
        rects.reduce(nil as Rect3D?) { result, next in
            result?.union(next) ?? next
        }
    }
}
