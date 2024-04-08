//
// Created by John Griffin on 4/7/24
//

import Foundation
import RealityKit
import Spatial

public struct Line3D: ChartContent, ModelEntityRepresentable, Posed {
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

    public var position: Point3D = .zero

    public var anchor: BoundsAnchor? {
        BoundsAnchor(offset: -Vector3D((from.vector + to.vector) / 2.0))
    }

    public var rotation: Rotation3D? {
        Vector3D.up.rotation(to: to - from)
    }

    // MARK: - MeshModeling

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: Float(from.distance(to: to)), radius: width)
    }
}

public struct Lines3D: ChartContent, EntityRepresentable, NotPosed {
    public let points: [Point3D]
    public let width: Float
    public var material: ChartMaterial?

    public init(
        points: [Point3D],
        width: Float = Charts.defaultLineWidth,
        material: ChartMaterial? = nil
    ) {
        self.points = points
        self.width = width
        self.material = material
    }

    // MARK: - Bounded

    public var bounds: Rect3D? {
        Rect3D(points: points)
    }

    public func contentsFor(_: RenderEnvironment?) -> [any ChartContent] {
        zip(points, points.dropFirst()).map { p1, p2 in
            Line3D(from: p1, to: p2, width: width, material: material)
        }
    }

    public func makeEntity() throws -> Entity {
        Entity()
    }
}
