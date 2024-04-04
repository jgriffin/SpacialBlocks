//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public struct Chart3DBox: Chart3DEntity, Chart3DMeshMaterializable {
    public var id: Chart3DID

    public var position: Point3D
    public var size: Size3D
    public var unitAnchorInSize: Point3D = .half
    public var rotation: Rotation3D?

    public var material: Chart3DMaterial
}

public extension Chart3DBox {
    func makeMesh() -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }

    func updateEntity(_ entity: Entity) throws {
        try updateModelComponent(entity)
        throw Chart3DError.notYetImplemented
    }
}
