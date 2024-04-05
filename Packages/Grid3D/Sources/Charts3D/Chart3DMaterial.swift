//
// Created by John Griffin on 4/4/24
//

import RealityKit
import UIKit

public protocol Chart3DMaterializable {
    func makeMaterial() -> RealityKit.Material
}

public enum Chart3DMaterial: Chart3DMaterializable {
    case simple(color: SimpleMaterial.Color, roughness: Float, isMetalic: Bool)
}

public extension Chart3DMaterial {
    func makeMaterial() -> any Material {
        switch self {
        case let .simple(color: color, roughness: roughness, isMetalic: isMetalic):
            SimpleMaterial(color: color, roughness: .float(roughness), isMetallic: isMetalic)
        }
    }
}
