//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - ModelRepresentable

public protocol ModelRepresentable: EntityRepresentable {
    func makeModelComponent() throws -> ModelComponent
    func updateEntityModel(_ entity: Entity) throws
}

public extension ModelRepresentable {
    func makeEntity() throws -> Entity {
        ModelEntity()
    }

    func updateEntityModel(_ entity: Entity) throws {
        let model = try makeModelComponent()
        entity.components[ModelComponent.self] = model
    }
}

// MARK: - MeshMaterialModeling

public protocol MeshModeled: ModelRepresentable {
    func makeMesh() -> MeshResource
    var material: ChartMaterial? { get set }
}

public extension MeshModeled {
    func makeMaterials(for mesh: MeshResource) -> [Material] {
        let chartMaterial = material ?? .simple(color: .blue, roughness: 1, isMetalic: true)
        let material = chartMaterial.makeMaterial()
        return Array(repeating: material, count: mesh.expectedMaterialCount)
    }

    func makeModelComponent() throws -> ModelComponent {
        let mesh = makeMesh()
        return ModelComponent(
            mesh: mesh,
            materials: makeMaterials(for: mesh)
        )
    }

    // MARK: modifiers

    func withMaterial(_ material: ChartMaterial) -> Self {
        copy(self) { $0.material = material }
    }
}
