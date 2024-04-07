//
// Created by John Griffin on 4/7/24
//

import Foundation
import RealityKit
import Spatial

public struct Line3D: ChartContent, MeshModeled, Positioned {
    public let from: Point3D
    public let to: Point3D
    public let width: Float
    public var material: ChartMaterial?

    public init(
        from: Point3D,
        to: Point3D,
        width: Float = Charts.defaultLineWidth,
        material: ChartMaterial? = nil
    ) {
        self.from = from
        self.to = to
        self.width = width
        self.material = material
    }

    // MARK: - Bounded

    public var bounds: Rect3D? {
        Rect3D(points: [from, to])
    }

    // MARK: Positioned

    public var position: Point3D {
        Point3D((from.vector + to.vector) / 2.0)
    }

    public var rotation: Rotation3D? {
        Vector3D.up.rotation(to: to - from)
    }

    // MARK: - MeshModeling

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: Float(from.distance(to: to)), radius: width)
    }
}
