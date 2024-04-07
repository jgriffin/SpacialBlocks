//
// Created by John Griffin on 4/6/24
//

import Foundation
import Spatial

/// Entities are positioned by setting the .postion of the implicit .zero origin in a parent
/// That generally creates things centered around the position point. But often times it's easier
/// to think about postioning relative the the bounds: e.g. postiion the .bottomLeft at 2,2,2.
///
/// Other times, you just want to always move it (0.5, 0.5, 0.5) units. Or one after the other
public struct BoundsAnchor {
    public var unitPoint: Unit3D?
    public var offset: Vector3D?

    public init(
        _ unitPoint: Unit3D? = nil,
        offset: Vector3D? = nil
    ) {
        self.unitPoint = unitPoint
        self.offset = offset
    }

    public static let center = BoundsAnchor(.center)

    // anchorPoint first tries to find anchorPointInBounds in bounds
    // if both are set otherwise it's .zero. Then, the anchorOffset will be
    // applied on top of that, if present.
    public func anchorPoint(in bounds: Rect3D?) -> Vector3D {
        var p = Vector3D.zero

        if let unitPoint,
           let bounds
        {
            p = Vector3D(bounds.min.vector + bounds.size.vector * unitPoint.vector)
        }

        if let offset {
            p += offset
        }

        return p
    }
}
