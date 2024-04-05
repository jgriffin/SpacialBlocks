//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol TransformableContent {
    var transform: Pose3D { get }
}

public extension TransformableContent {
    func updateTransformComponent(_ entity: Entity) throws {
        entity.position = SIMD3(transform.position) * [1, 1, -1]
        // TODO: rotation
    }
}
