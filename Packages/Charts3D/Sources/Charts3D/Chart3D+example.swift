//
// Created by John Griffin on 4/7/24
//

import Foundation
import Spatial

public extension Chart3D {
    static let stairs = Chart3D {
        Box3D(position: .init([0.0, 0.0, 0.0]))
        Box3D(position: .init([1.0, 1.0, 1.0]))
        Box3D(position: .init([2.0, 2.0, 2.0]))
        Box3D(position: .init([3.0, 3.0, 3.0]))
        Box3D(position: .init([4.0, 4.0, 4.0]))

        Box3D(position: .init([0.0, 4.0, 4.0]))
        Box3D(position: .init([0.0, 4.0, 0.0]))
        Box3D(position: .init([4.0, 4.0, 0.0]))
        Box3D(position: .init([0.0, 0.0, 4.0]))
        Box3D(position: .init([4.0, 0.0, 0.0]))

        GridPlanes3D()
    }

    static let random = Chart3D {
        Box3D()
        Box3D(position: .init(.one))
        Box3D(size: .init(.one * 2.0), position: Point3D([1.0, 2.0, 4.0]))

        Sphere3D(radius: 1, position: .init([1.0, 5.0, -1.0]))
        Cone3D(height: 2, radius: 1, position: .init([2.0, 2.0, -1.0]))
        Cylinder3D(height: 2, radius: 1, position: .init([7.0, 2.0, -1.0]))
        Plane3D(u: .right * 5.0,
                v: .up * 4.0,
                cornerRadius: 0.01,
                position: .init([5.0, 5.0, 8.0]))

        GridPlanes3D()
    }

    static let current = Chart3D {
        Box3D(size: .one * -0.1, material: .color(.cyan, alpha: 0.2))
        Line3D(from: Point3D([0.0, 0, 0]), to: Point3D([1.0, 1, 11]))
        
        GridPlanes3D()
    }.withBoundsToInclude([.zero, .one])
}
