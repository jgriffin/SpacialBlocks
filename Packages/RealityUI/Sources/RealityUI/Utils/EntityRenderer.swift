//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public protocol EntityRenderer<EntityType> {
    associatedtype EntityType: Entity
    var name: String { get }
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
    public let name: String

    public init(mesh: MeshResource, material: RealityMaterial, name: String) {
        self.mesh = mesh
        self.material = material
        self.name = name
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
    public let name: String

    public init(_ transform: AffineTransform3D, name: String = "Transform") {
        self.transform = transform
        self.name = name
    }

    public init(translation: Vector3D, name: String = "Translation") {
        self.init(AffineTransform3D(translation: translation), name: name)
    }

    public init(alignment: Vector3D, name: String = "Alignment") {
        self.init(AffineTransform3D(translation: alignment), name: name)
    }

    public func makeEntity() -> Entity {
        let entity = Entity()
        updateEntity(entity)
        return entity
    }

    public func updateEntity(_ entity: Entity) {
        #if os(visionOS)
            entity.transform = Transform(transform)
        #else
            let cols = transform.matrix4x4.columns
            let floatMatrix = matrix_float4x4(columns: (.init(cols.0), .init(cols.1), .init(cols.2), .init(cols.3)))
            entity.transform = Transform(matrix: floatMatrix)
        #endif
    }
}
