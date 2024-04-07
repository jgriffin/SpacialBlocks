//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - box

public struct Box3D: ChartContent, MeshMaterialModeling, Positionable, Sizeable, Anchorable {
    public var size: Size3D
    public var position: Point3D
    public var positionAnchor: BoundsAnchor?
    public var material: ChartMaterial?

    public init(
        size: Size3D = Charts.defaultBoxSize,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = nil,
        material: ChartMaterial? = nil
    ) {
        self.size = size
        self.position = position
        positionAnchor = anchor
        self.material = material
    }

    public func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

// MARK: - sphere

public struct Sphere3D: ChartContent, MeshMaterialModeling, Positionable, Anchorable {
    public var radius: Float
    public var position: Point3D
    public var positionAnchor: BoundsAnchor?
    public var material: ChartMaterial?

    public init(
        radius: Float,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = nil,
        material: ChartMaterial? = nil
    ) {
        self.radius = radius
        self.position = position
        positionAnchor = anchor
        self.material = material
    }

    public var bounds: Rect3D? {
        Rect3D(
            center: position,
            size: Size3D(vector: .one).uniformlyScaled(by: Double(radius))
        )
    }

    public func makeMesh() -> MeshResource {
        .generateSphere(radius: radius)
    }
}

public struct Plane3D: ChartContent, MeshMaterialModeling, Positionable, Rotateable {
    public var width: Float
    public var height: Float
    public var cornerRadius: Float

    public var position: Point3D
    public var positionAnchor: BoundsAnchor?
    public var rotation: Rotation3D
    public var material: ChartMaterial?

    public init(
        width: Float,
        height: Float,
        cornerRadius: Float = 0,
        position: Point3D = .zero,
        anchor: BoundsAnchor? = nil,
        rotation: Rotation3D = .identity,
        material: ChartMaterial? = nil
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius

        self.position = position
        positionAnchor = anchor
        self.rotation = rotation
        self.material = material
    }

    public var bounds: Rect3D? {
        let rect = Rect3D(center: .zero, size: .init(width: width, height: height, depth: cornerRadius))
        return rect.applying(pose)
    }

    public func makeMesh() -> MeshResource {
        .generatePlane(width: width, height: height, cornerRadius: cornerRadius)
    }
}

// MARK: - cone

public struct Cone3D: ChartContent, MeshMaterialModeling, Positionable, Rotateable {
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

    public var bounds: Rect3D? {
        Rect3D(
            origin: position,
            size: Size3D(vector: .one).uniformlyScaled(by: Double(max(height, radius)))
        )
    }

    public func makeMesh() -> MeshResource {
        .generateCone(height: height, radius: radius)
    }
}

// MARK: - cylindar

public struct Cylinder3D: ChartContent, MeshMaterialModeling, Positionable, Rotateable {
    public var height: Float
    public var radius: Float
    public var position: Point3D
    public var positionAnchor: BoundsAnchor?
    public var rotation: Rotation3D
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
        positionAnchor = anchor
        self.rotation = rotation
        self.material = material
    }

    public var bounds: Rect3D? {
        Rect3D(
            origin: position,
            size: Size3D(vector: .one).uniformlyScaled(by: Double(min(height, radius)))
        )
    }

    public func makeMesh() -> MeshResource {
        .generateCylinder(height: height, radius: radius)
    }
}
