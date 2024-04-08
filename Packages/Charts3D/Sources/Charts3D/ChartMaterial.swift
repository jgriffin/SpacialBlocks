//
// Created by John Griffin on 4/4/24
//

import RealityKit
import UIKit

public protocol Materializable {
    func makeMaterial() -> RealityKit.Material
}

public enum ChartMaterial: Materializable {
    case simple(color: SimpleMaterial.Color, roughness: Float, isMetalic: Bool)

    // MARK: - materializable

    public func makeMaterial() -> any Material {
        switch self {
        case let .simple(color: color, roughness: roughness, isMetalic: isMetalic):
            SimpleMaterial(color: color, roughness: .float(roughness), isMetallic: isMetalic)
        }
    }
}

public extension ChartMaterial {
    static func color(
        _ color: SimpleMaterial.Color,
        alpha: CGFloat? = nil,
        roughness: Float = 1,
        isMetalic: Bool = false
    ) -> ChartMaterial {
        let color = alpha.flatMap { color.withAlphaComponent($0) } ?? color
        return .simple(color: color, roughness: roughness, isMetalic: isMetalic)
    }
}
