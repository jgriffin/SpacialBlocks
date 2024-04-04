//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public protocol Chart3DEntity: Chart3DPosable {
    var id: Chart3DID { get }

    func makeEntity() throws -> Entity
    func updateEntity(_: Entity) throws
}

public protocol Chart3DPosable {
    var position: Point3D { get set }
    var size: Size3D { get set }
    var unitAnchorInSize: Point3D { get set }

    var rotation: Rotation3D? { get set }
}

public extension Chart3DPosable {
    var pose: Pose3D {
        let anchorOffset = (unitAnchorInSize - .half).vector * size.vector
        let biasedPostion = Point3D(position.vector + anchorOffset)

        return Pose3D(position: biasedPostion, rotation: rotation ?? .identity)
    }

    func updateTransform(_ entity: Entity) throws {
        // TODO: rotation
        entity.position = SIMD3(pose.position)
    }
}

public protocol Chart3DMeshable {
    func makeMesh() -> MeshResource
}

public protocol Chart3DMeshMaterializable: Chart3DMeshable {
    var material: Chart3DMaterial { get }
}

public extension Chart3DEntity where Self: Chart3DMeshMaterializable {
    func makeEntity() throws -> Entity {
        let modelEntity = ModelEntity()
        try updateModelComponent(modelEntity)
        return modelEntity
    }

    func updateModelComponent(_ entity: Entity) throws {
        let mesh = makeMesh()
        let material = material.makeMaterial()
        entity.components[ModelComponent.self] = ModelComponent(
            mesh: mesh,
            materials: Array(repeating: material, count: mesh.expectedMaterialCount)
        )
    }
}
