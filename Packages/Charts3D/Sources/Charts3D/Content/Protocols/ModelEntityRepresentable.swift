//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol ModelEntityRepresentable: EntityRepresentable {
    func makeMesh() -> MeshResource
    var material: ChartMaterial? { get set }

    func updateEntityModel(_ entity: Entity) throws
}

public extension ModelEntityRepresentable {
    // MARK: - EntityRepresentable

    func makeEntity() throws -> Entity {
        ModelEntity()
    }

    // MARK: - ModelEntityRepresentable

    func makeModelComponent() throws -> ModelComponent {
        let mesh = makeMesh()
        return ModelComponent(
            mesh: mesh,
            materials: makeMaterials(for: mesh)
        )
    }

    func makeMaterials(for mesh: MeshResource) -> [Material] {
        let chartMaterial = material ?? .color(.blue)
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
