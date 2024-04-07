//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol Posed: Bounded {
    var pose: Pose3D { get }
}

public extension Posed {
    // MARK: - Bounded

    var frame: Rect3D? {
        bounds?.applying(pose)
    }

    var containedFrame: Rect3D? {
        containedBounds?.applying(pose)
    }

    // MARK: - render helper

    func updateEnityPose(_ entity: Entity) throws {
        let pose = pose

        let transform3D = AffineTransform3D(
            rotation: pose.rotation,
            translation: pose.position.asVector
        )
        entity.transform = Transform(transform3D)
    }
}
