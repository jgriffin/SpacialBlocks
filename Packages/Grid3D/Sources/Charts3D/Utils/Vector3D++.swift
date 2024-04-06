//
// Created by John Griffin on 4/4/24
//

import Spatial

public extension Vector3D {
    static let half = Vector3D([0.5, 0.5, 0.5])
    static let zFlip = Vector3D([1.0, 1.0, -1.0])
}

public extension SIMD3<Float> {
    static let half: SIMD3<Float> = [0.5, 0.5, 0.5]
    static let zFlip: SIMD3<Float> = [1, 1, -1]

    var flipZ: SIMD3<Float> { self * .zFlip }
}
