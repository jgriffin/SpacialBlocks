//
// Created by John Griffin on 4/2/24
//

import RealityKit
import UIKit

public enum GridMaterials {
    private static var gridMaterialsScene: Entity? = try? Entity.load(
        named: "GridMaterials",
        in: realityKitContentBundle
    )

    public private(set) static var unitGridLinesShader: ShaderGraphMaterial? =
        gridMaterialsScene?.findShaderMaterial(holderName: "UnitGridLinesHolder")
    public private(set) static var lineCountShader: ShaderGraphMaterial? =
        gridMaterialsScene?.findShaderMaterial(holderName: "LineCountHolder")
    public private(set) static var absPlasticShader: ShaderGraphMaterial? =
        gridMaterialsScene?.findShaderMaterial(holderName: "ABSPlasticHolder")

    enum LoadingError: Error {
        case holderNotFound
        case loadingError
    }
}

public extension ShaderGraphMaterial {
    func updateUnitsGridLinesParameters(
        gridUnits: SIMD3<Float>? = nil,
        lineWidth: Float? = nil,
        gridLineColor: UIColor? = nil,
        baseColor: UIColor? = nil,
        centerBias: SIMD3<Float>? = nil
    ) throws -> ShaderGraphMaterial {
        var material = self
        if let gridUnits {
            try material.setParameter(name: "gridUnits", value: .simd3Float(gridUnits))
        }
        if let lineWidth {
            try material.setParameter(name: "gridLineWidth", value: .float(lineWidth))
        }
        if let gridLineColor {
            try material.setParameter(name: "gridLineColor", value: .color(gridLineColor.cgColor))
        }
        if let baseColor {
            try material.setParameter(name: "baseColor", value: .color(baseColor.cgColor))
        }
        if let centerBias {
            try material.setParameter(name: "centerBias", value: .simd3Float(centerBias))
        }

        return material
    }

    func updateLineCountParameters(
        lineCounts: SIMD2<Float>? = nil,
        lineWidths: SIMD2<Float>? = nil,
        lineColor: UIColor? = nil,
        baseColor: UIColor? = nil
    ) throws -> ShaderGraphMaterial {
        var material = self

        if let lineCounts {
            try material.setParameter(name: "lineCounts", value: .simd2Float(lineCounts))
        }
        if let lineWidths {
            try material.setParameter(name: "lineWidths", value: .simd2Float(lineWidths))
        }
        if let lineColor {
            try material.setParameter(name: "lineColor", value: .color(lineColor))
        }
        if let baseColor {
            try material.setParameter(name: "baseColor", value: .color(baseColor))
        }

        return material
    }

    func updateABSPlasticParameters(
        baseColorTint: UIColor?
    ) throws -> ShaderGraphMaterial {
        var material = self

        if let baseColorTint {
            try material.setParameter(name: "Basecolor_Tint", value: .color(baseColorTint.cgColor))
        }

        return material
    }
}
