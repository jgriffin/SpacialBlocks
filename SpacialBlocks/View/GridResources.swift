//
// Created by John Griffin on 3/30/24
//

import RealityKit
import RealityKitContent

struct GridResources {
    let cubeGrid: Entity
    let gridRoot: Entity
    let lightGridMaterial: ShaderGraphMaterial
    let gridMaterial: ShaderGraphMaterial
    let plasticMaterial: RealityKit.Material

    @MainActor
    static func loadResources() async -> GridResources? {
        guard let scene = try? await Entity(named: "CubeGrid", in: realityKitContentBundle),
              let gridRoot = scene.findEntity(named: "gridRoot"),
              let gridMaterial = try? await gridMaterialShader(),
              let lightGridMaterial = try? await lightGridMaterialShader(),
              let plasticMaterial = try? await plasticMaterialShader()
                //loadMaterial(holderName: "plasticMaterialHolder", in: scene)
        else {
            return nil
        }

        return GridResources(
            cubeGrid: scene,
            gridRoot: gridRoot,
            lightGridMaterial: lightGridMaterial,
            gridMaterial: gridMaterial,
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
