//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public protocol EntityRenderer<EntityType> {
    associatedtype EntityType: Entity

    func makeEntity() -> EntityType
    func updateEntity(_ entity: EntityType)
}

public extension EntityRenderer {
    func asNode(children: [RenderNode] = []) -> RenderNode {
        RenderNode(self, children: children)
    }
}

// MARK: - Entity renderers

public struct EmptyEntity: EntityRenderer {
    public let name: String

    public init(name: String = "EmptyEntity") {
        self.name = name
    }

    public func makeEntity() -> Entity {
        let empty = Entity()
        empty.name = name
        return empty
    }

    public func updateEntity(_: Entity) {}
}

public struct MeshEntity: EntityRenderer {
    public typealias EntityType = ModelEntity

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

public struct TransformEntity: EntityRenderer {
    public let transform: AffineTransform3D

    public init(_ transform: AffineTransform3D) {
        self.transform = transform
    }

    public init(translation: Vector3D) {
        transform = AffineTransform3D(translation: translation)
    }

    public func makeEntity() -> Entity {
        let entity = Entity()
        updateEntity(entity)
        return entity
    }

    public func updateEntity(_ entity: Entity) {
        entity.transform = Transform(transform)
    }
}
