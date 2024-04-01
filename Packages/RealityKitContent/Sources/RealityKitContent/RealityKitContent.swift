import Foundation
import RealityKit

/// Bundle for the RealityKitContent project
public let realityKitContentBundle = Bundle.module

public func gridMaterialShader() async throws -> ShaderGraphMaterial {
    try await ShaderGraphMaterial(
        named: "/Root/Materials/GridMaterial",
        from: "GridMaterials.usda",
        in: realityKitContentBundle
    )
}

public func lightGridMaterialShader() async throws -> ShaderGraphMaterial {
    try await ShaderGraphMaterial(
        named: "/Root/Materials/LightGridMaterial",
        from: "GridMaterials.usda",
        in: realityKitContentBundle
    )
}

public func plasticMaterialShader() async throws -> ShaderGraphMaterial {
    try await ShaderGraphMaterial(
        named: "/Root/BlackABSPlastic",
        from: "BlackABSPlastic.usda",
        in: realityKitContentBundle
    )
}

