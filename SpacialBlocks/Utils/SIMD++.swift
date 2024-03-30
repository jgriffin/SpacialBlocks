//
// Created by John Griffin on 3/28/24
//

import Foundation

extension SIMD3 {
    var scalars: [Scalar] {
        indices.map { self[$0] }
    }

    var desc: String {
        scalars.description
    }
}

extension SIMD3<Float> {
    static let half: SIMD3<Float> = [0.5, 0.5, 0.5]
    static let zFlip: SIMD3<Float> = [1, 1, -1]
    static let halfZFlip: SIMD3<Float> = half * zFlip
}
