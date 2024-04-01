//
// Created by John Griffin on 3/30/24
//

import RealityKit
import RealityKitContent

struct GridResources {
    let unitsGridMaterial: ShaderGraphMaterial
    let plasticMaterial: RealityKit.Material

    @MainActor
    static func loadResources() async -> GridResources? {
        guard let gridMaterial = try? await unitsGridShaderMaterial(),
              let plasticMaterial = try? await absPlasticMaterial(baseColorTint: .green)
        else {
            return nil
        }

        return GridResources(
            unitsGridMaterial: gridMaterial,
            plasticMaterial: plasticMaterial
        )
    }

    static func loadMaterial(holderName: String, in parent: Entity) -> RealityKit.Material? {
        parent.findEntity(named: holderName)?
            .components[ModelComponent.self]?
            .materials
            .first
    }
}
