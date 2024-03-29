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
