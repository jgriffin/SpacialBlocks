//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - box

public struct Box3D: ChartContent, ModelEntityRepresentable, Poseable {
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

    // MARK: - modifiers

    func withSize(_ size: Size3D) -> Self {
        modify(self) { $0.size = size }
    }
}

// MARK: - sphere

public struct Sphere3D: ChartContent, ModelEntityRepresentable, Poseable {
    public var radius: Double

    public var position: Point3D
    public var anchor: BoundsAnchor?
    public var rotation: Rotation3D?

    public var material: ChartMaterial?

    public init(
        radius: Double,
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
        Size3D(vector: .one * radius).asCenterRect
    }

    public func makeMesh() -> MeshResource {
        .generateSphere(radius: Float(radius))
    }
}

public struct Plane3D: ChartContent, ModelEntityRepresentable, Posed {
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
        Size3D(
            width: u.length,
            height: v.length,
            depth: cornerRadius
        ).asCenterRect
    }

    public var rotation: Rotation3D? {
        Vector3D.forward.rotation(to: u.cross(v))
    }

    public func makeMesh() -> MeshResource {
        .generateTwoSidedPlane(
            width: Float(u.length),
            height: Float(v.length),
            cornerRadius: Float(cornerRadius)
        )
    }
}

// MARK: - cone

public struct Cone3D: ChartContent, ModelEntityRepresentable, Poseable {
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

public struct Cylinder3D: ChartContent, ModelEntityRepresentable, Poseable {
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
        Size3D(width: 2.0 * radius, height: height, depth: 2.0 * radius).asCenterRect
    }

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: height, radius: radius)
    }
}
