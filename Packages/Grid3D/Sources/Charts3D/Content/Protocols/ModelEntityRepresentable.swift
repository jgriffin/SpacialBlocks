//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - ModelRepresentable

public protocol ModelEntityRepresentable: EntityRepresentable {
    func makeModelComponent() throws -> ModelComponent
    func updateModelComponent(_ entity: Entity) throws
}

public extension ModelEntityRepresentable {
    func makeEntity() throws -> Entity {
        ModelEntity()
    }

    func updateModelComponent(_ entity: Entity) throws {
        let model = try makeModelComponent()
        entity.components[ModelComponent.self] = model
    }
}

// MARK: - MeshMaterialRepresentable

public protocol MeshMaterialRepresentableContent: ModelEntityRepresentable {
    func makeMesh() -> MeshResource
    var material: ChartMaterial? { get set }
}

public extension MeshMaterialRepresentableContent {
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
