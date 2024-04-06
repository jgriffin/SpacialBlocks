//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public struct Chart3DBox:
    MeshMaterialRepresentableContent,
    PositionableContent,
    SizeableContent,
    SizeAnchorableContent
{
    public var size: Size3D
    public var position: Point3D
    public var unitAnchorInSize: Vector3D

    public var material: Chart3DMaterial?

    public init(
        id _: ContentID = UUID(),
        size: Size3D = Defaults.boxSize,
        position: Point3D = .zero,
        unitAnchorInSize: Vector3D = Defaults.boxUnitAnchor,
        material: Chart3DMaterial? = nil
    ) {
        self.size = size
        self.position = position
        self.unitAnchorInSize = unitAnchorInSize
        self.material = material
    }
}

public extension Chart3DBox {
    func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}
