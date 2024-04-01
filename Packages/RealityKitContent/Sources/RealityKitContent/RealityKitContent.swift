import Foundation
import RealityKit
import UIKit

/// Bundle for the RealityKitContent project
public let realityKitContentBundle = Bundle.module

public func unitsGridShaderMaterial(
    gridUnits: SIMD3<Float> = [1, 1, 1],
    lineWidth: Float = 0.03,
    gridLineColor: UIColor? = nil,
    baseColor: UIColor? = nil
) async throws -> ShaderGraphMaterial {
    var material = try await ShaderGraphMaterial(
        named: "/Root/Materials/UnitGridLinesMaterial",
        from: "GridMaterials.usda",
        in: realityKitContentBundle
    )
        
    try material.setParameter(name: "gridUnits", value: .simd3Float(gridUnits))
    try material.setParameter(name: "gridLineWidth", value: .float(lineWidth))
        
    if let gridLineColor {
        try material.setParameter(name: "gridLineColor", value: .color(gridLineColor.cgColor))
    }
    if let baseColor {
        try material.setParameter(name: "baseColor", value: .color(baseColor.cgColor))
    }
        
    return material
}

public func absPlasticMaterial(
    baseColorTint: UIColor? = nil
) async throws -> ShaderGraphMaterial? {
    let gridMaterials = try await Entity(named: "GridMaterials", in: realityKitContentBundle)
    
    guard let holder = await gridMaterials.findEntity(named: "ABSPlasticHolder"),
          let model = await (holder as? ModelEntity)?.model,
          let material = model.materials.first,
          var shaderMaterial = material as? ShaderGraphMaterial
    else {
        return nil
    }
        
    if let baseColorTint {
        print(shaderMaterial.parameterNames)
        try shaderMaterial.setParameter(name: "Basecolor_Tint", value: .color(baseColorTint.cgColor))
    }
        
    return shaderMaterial
}
