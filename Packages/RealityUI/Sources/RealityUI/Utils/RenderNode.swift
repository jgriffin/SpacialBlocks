//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RenderNode

public struct RenderNode {
    public init(renderer: any EntityRenderer, children: [RenderNode]) {
        self.renderer = renderer
        self.children = children
    }

    public var renderer: any EntityRenderer
    public var children: [RenderNode]
}

// MARK: - EntityRenderer

public protocol EntityRenderer {
    associatedtype EntityType: Entity

    func makeEntity() -> EntityType
    func updateEntity(_ entity: EntityType)
}

// MARK: - Entity renderers

public struct EmptyEntityRenderer: EntityRenderer {
    public func makeEntity() -> Entity { Entity() }

    public func updateEntity(_: Entity) {}
}

public struct MeshEntityRenderer: EntityRenderer {
    public let mesh: MeshResource
    public let material: RealityMaterial

    public init(mesh: MeshResource, material: RealityMaterial) {
        self.mesh = mesh
        self.material = material
    }

    public func makeEntity() -> ModelEntity {
        let entity = ModelEntity()
        updateEntity(entity)
        return entity
    }

    public func updateEntity(_ entity: ModelEntity) {
        let materials = Array(repeating: material.makeMaterial(),
                              count: mesh.expectedMaterialCount)

        entity.components[ModelComponent.self] = ModelComponent(
            mesh: mesh,
            materials: materials
        )
    }
}

public struct PoseEntityRenderer: EntityRenderer {
    public let pose: Pose3D

    public init(pose: Pose3D) {
        self.pose = pose
    }

    public func makeEntity() -> Entity {
        let entity = Entity()
        updateEntity(entity)
        return entity
    }

    public func updateEntity(_ entity: Entity) {
        let transform = AffineTransform3D(pose: pose)
        entity.transform = Transform(transform)
    }
}
