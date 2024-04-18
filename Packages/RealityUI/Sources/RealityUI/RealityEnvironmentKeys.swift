//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension RealityEnvironment {
    var material: RealityMaterial {
        get { self[RealityMaterialKey.self] }
        set { self[RealityMaterialKey.self] = newValue }
    }
}

// MARK: - environment keys

enum RealityMaterialKey: RealityEnvironmentKey {
    static var defaultValue: RealityMaterial = .color(.blue)
}
