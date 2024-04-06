//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - box

public struct Box3D:
    MeshMaterialRepresentableContent,
    Positionable,
    Sizeable,
    SizeAnchorable
{
    public var size: Size3D
    public var position: Point3D
    public var unitAnchorInSize: Vector3D

    public var material: ChartMaterial?

    public init(
        size: Size3D = Charts.defaultBoxSize,
        position: Point3D = .zero,
        unitAnchorInSize: Vector3D = Charts.defaultBoxUnitAnchor,
        material: ChartMaterial? = nil
    ) {
        self.size = size
        self.position = position
        self.unitAnchorInSize = unitAnchorInSize
        self.material = material
    }

    public func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

// MARK: - sphere

public struct Sphere3D:
    MeshMaterialRepresentableContent,
    Positionable
{
    public var radius: Float
    public var position: Point3D
    public var material: ChartMaterial?

    public init(
        radius: Float,
        position: Point3D,
        material: ChartMaterial? = nil
    ) {
        self.radius = radius
        self.position = position
        self.material = material
    }

    public func makeMesh() -> MeshResource {
        .generateSphere(radius: radius)
    }
}

public struct Plane3D:
    MeshMaterialRepresentableContent,
    Positionable, Rotateable
{
    public var width: Float
    public var height: Float
    public var cornerRadius: Float

    public var position: Point3D
    public var rotation: Rotation3D
    public var material: ChartMaterial?

    public init(
        width: Float,
        height: Float,
        cornerRadius: Float = 0,
        position: Point3D = .zero,
        rotation: Rotation3D = .identity,
        material: ChartMaterial? = nil
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius

        self.position = position
        self.rotation = rotation
        self.material = material
    }

    public func makeMesh() -> MeshResource {
        .generatePlane(width: width, height: height, cornerRadius: cornerRadius)
    }
}

// MARK: - cone

public struct Cone3D:
    MeshMaterialRepresentableContent,
    Positionable,
    Rotateable
{
    public var height: Float
    public var radius: Float
    public var position: Point3D
    public var rotation: Rotation3D
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

    public func makeMesh() -> MeshResource {
        .generateCone(height: height, radius: radius)
    }
}

// MARK: - cylindar

public struct Cylinder3D:
    MeshMaterialRepresentableContent,
    Positionable, Rotateable
{
    public var height: Float
    public var radius: Float
    public var position: Point3D
    public var rotation: Rotation3D
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

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: height, radius: radius)
    }
}
