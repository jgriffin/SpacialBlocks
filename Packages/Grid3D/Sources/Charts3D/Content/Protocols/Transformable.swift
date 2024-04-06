//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol Transformable {
    var transform: Pose3D { get }
}

public extension Transformable {
    func updateTransformComponent(_ entity: Entity) throws {
        entity.position = SIMD3(transform.position) * [1, 1, -1]
        // TODO: rotation
    }
}
