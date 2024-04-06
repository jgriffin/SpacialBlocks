//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol Posed {
    var pose: Pose3D { get }
}

public extension Posed {
    func updateTransformComponent(_ entity: Entity) throws {
        let pose = pose

        let transform3D = AffineTransform3D(
            rotation: pose.rotation,
            translation: Vector3D(pose.position.vector.flipZ)
        )

        entity.transform = Transform(transform3D)
        // TODO: rotation
    }
}
