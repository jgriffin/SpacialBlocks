//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - box

public struct Box3D: ChartContent, ModelRepresentable, Poseable, Sizeable {
    public var size: Size3D

    public var position: Point3D
    public var anchor: BoundsAnchor?
    public var rotation: Rotation3D?

    public var material: ChartMaterial?

    public init(
        size: Size3D = Charts.defaultSize,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = nil,
        material: ChartMaterial? = nil
    ) {
        self.size = size
        self.position = position
        self.anchor = anchor
        self.material = material
    }

    public var bounds: Rect3D? {
        size.asCenterRect
    }

    public func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

// MARK: - sphere

public struct Sphere3D: ChartContent, ModelRepresentable, Poseable {
    public var radius: Float

    public var position: Point3D
    public var anchor: BoundsAnchor?
    public var rotation: Rotation3D?

    public var material: ChartMaterial?

    public init(
        radius: Float,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = nil,
        material: ChartMaterial? = nil
    ) {
        self.radius = radius
        self.position = position
        self.anchor = anchor
        self.material = material
    }

    public var bounds: Rect3D? {
        Rect3D(
            center: .zero,
            size: Size3D(vector: .one).uniformlyScaled(by: Double(radius))
        )
    }

    public func makeMesh() -> MeshResource {
        .generateSphere(radius: radius)
    }
}

public struct Plane3D: ChartContent, ModelRepresentable, Posed {
    public var u: Vector3D
    public var v: Vector3D
    public var cornerRadius: Double

    public var position: Point3D
    public var anchor: BoundsAnchor?

    public var material: ChartMaterial?

    public init(
        u: Vector3D,
        v: Vector3D,
        cornerRadius: Double = 0.01,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = .center,
        material: ChartMaterial? = nil
    ) {
        self.u = u
        self.v = v
        self.cornerRadius = cornerRadius

        self.position = position
        self.anchor = anchor
        self.material = material
    }

    public var bounds: Rect3D? {
        Rect3D(
            origin: .zero,
            size: .init(width: u.length, height: v.length, depth: cornerRadius)
        )
    }

    public var rotation: Rotation3D? {
        let look = Point3D(u.cross(v))
        return Rotation3D(position: look, target: .zero)
    }

    public func makeMesh() -> MeshResource {
        .generatePlane(width: Float(u.length), height: Float(v.length), cornerRadius: Float(cornerRadius))
    }
}

// MARK: - cone

public struct Cone3D: ChartContent, ModelRepresentable, Poseable {
    public var height: Float
    public var radius: Float

    public var position: Point3D
    public var anchor: BoundsAnchor?
    public var rotation: Rotation3D?

    public var material: ChartMaterial?

    public init(
        height: Float,
        radius: Float,
        position: Point3D,
        rotation: Rotation3D = .identity,
        material: ChartMaterial? = nil
    ) {
        self.height = height
        self.radius = radius
        self.position = position
        self.rotation = rotation
        self.material = material
    }

    public var bounds: Rect3D? {
        Size3D(width: 2.0 * radius, height: height, depth: 2 * radius).asCenterRect
    }

    public func makeMesh() -> MeshResource {
        .generateCone(height: height, radius: radius)
    }
}

// MARK: - cylindar

public struct Cylinder3D: ChartContent, ModelRepresentable, Poseable {
    public var height: Float
    public var radius: Float

    public var position: Point3D
    public var anchor: BoundsAnchor?
    public var rotation: Rotation3D?

    public var material: ChartMaterial?

    public init(
        height: Float,
        radius: Float,
        position: Point3D,
        anchor: BoundsAnchor? = nil,
        rotation: Rotation3D = .identity,
        material: ChartMaterial? = nil
    ) {
        self.height = height
        self.radius = radius
        self.position = position
        self.anchor = anchor
        self.rotation = rotation
        self.material = material
    }

    public var bounds: Rect3D? {
        Rect3D(
            center: .zero,
            size: Size3D(width: 2.0 * radius, height: height, depth: 2.0 * radius)
        )
    }

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: height, radius: radius)
    }
}
