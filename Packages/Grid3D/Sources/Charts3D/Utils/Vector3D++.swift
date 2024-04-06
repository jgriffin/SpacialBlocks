//
// Created by John Griffin on 4/4/24
//

import Spatial

public extension Vector3D {
    static let half = Vector3D([0.5, 0.5, 0.5])
    static let zFlip = Vector3D([1.0, 1.0, -1.0])

    var flipZ: Vector3D { Vector3D(vector * .zFlip) }
}

public extension SIMD3<Float> {
    static let half: Self = [0.5, 0.5, 0.5]
    static let zFlip: Self = [1.0, 1.0, -1.0]

    var flipZ: Self { self * .zFlip }
}

public extension SIMD3<Double> {
    static let half: Self = [0.5, 0.5, 0.5]
    static let zFlip: Self = [1.0, 1.0, -1.0]

    var flipZ: Self { self * .zFlip }
}
