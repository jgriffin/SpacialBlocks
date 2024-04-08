//
// Created by John Griffin on 4/4/24
//

import RealityKit
import UIKit

public protocol Materializable {
    func makeMaterial() -> RealityKit.Material
}

public enum ChartMaterial: Materializable {
    case simple(color: SimpleMaterial.Color, roughness: Float = 1, isMetalic: Bool = false)

    // MARK: - materializable

    public func makeMaterial() -> any Material {
        switch self {
        case let .simple(color: color, roughness: roughness, isMetalic: isMetalic):
            SimpleMaterial(color: color, roughness: .float(roughness), isMetallic: isMetalic)
        }
    }
}
