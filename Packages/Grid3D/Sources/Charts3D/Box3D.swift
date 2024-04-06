//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

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
        id _: ContentID = UUID(),
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
}

public extension Box3D {
    func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}
