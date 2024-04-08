//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - ModelRepresentable

public protocol ModelRepresentable: EntityRepresentable {
    func makeMesh() -> MeshResource
    var material: ChartMaterial? { get set }

    func updateEntityModel(_ entity: Entity) throws
}

public extension ModelRepresentable {
    // MARK: - EntityRepresentable

    func makeEntity() throws -> Entity {
        ModelEntity()
    }

    // MARK: - ModelRepresentable

    func makeModelComponent() throws -> ModelComponent {
        let mesh = makeMesh()
        return ModelComponent(
            mesh: mesh,
            materials: makeMaterials(for: mesh)
        )
    }

    func makeMaterials(for mesh: MeshResource) -> [Material] {
        let chartMaterial = material ?? .simple(color: .blue, roughness: 1, isMetalic: true)
        let material = chartMaterial.makeMaterial()
        return Array(repeating: material, count: mesh.expectedMaterialCount)
    }

    func updateEntityModel(_ entity: Entity) throws {
        let model = try makeModelComponent()
        entity.components[ModelComponent.self] = model
    }

    // MARK: - modifiers

    func withMaterial(_ material: ChartMaterial) -> Self {
        modify(self) { $0.material = material }
    }
}
