//
// Created by John Griffin on 4/4/24
//

import RealityKit

public protocol Materializable {
    func makeMaterial() -> RealityKit.Material
}

public enum RealityMaterial: Materializable {
    case simple(color: SimpleMaterial.Color, roughness: Float, isMetalic: Bool)

    // MARK: - materializable

    public func makeMaterial() -> any Material {
        switch self {
        case let .simple(color: color, roughness: roughness, isMetalic: isMetalic):
            SimpleMaterial(color: color, roughness: .float(roughness), isMetallic: isMetalic)
        }
    }
}

public extension RealityMaterial {
    static func color(
        _ color: SimpleMaterial.Color,
        alpha: Double? = nil,
        roughness: Float = 1,
        isMetalic: Bool = false
    ) -> RealityMaterial {
        .simple(
            color: alpha.flatMap { color.withAlphaComponent($0) } ?? color,
            roughness: roughness,
            isMetalic: isMetalic
        )
    }
}
