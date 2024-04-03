//
// Created by John Griffin on 3/30/24
//

import RealityKit
import RealityKitContent

struct GridResources {
    let unitsGridMaterial: ShaderGraphMaterial
    let lineCountMaterial: ShaderGraphMaterial
    let plasticMaterial: ShaderGraphMaterial

    @MainActor
    static func loadResources() async throws -> GridResources {
        let unitsGrid = try GridMaterials.unitGridLinesShader
            .unwrapped("unitGridLinesShader")
            .updateUnitsGridLinesParameters(gridUnits: .one, lineWidth: 0.02)

        let lineCount = try GridMaterials.lineCountShader
            .unwrapped("lineCountShader")
            .updateLineCountParameters(lineCounts: [10, 10], lineWidths: [0.02, 0.02])

        let plastic = try GridMaterials.absPlasticShader
            .unwrapped("absPlasticShader")
            .updateABSPlasticParameters(baseColorTint: .blue)

        return GridResources(
            unitsGridMaterial: unitsGrid,
            lineCountMaterial: lineCount,
            plasticMaterial: plastic
        )
    }
}
