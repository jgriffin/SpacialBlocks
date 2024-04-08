//
// Created by John Griffin on 4/7/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - posed

public protocol Posed: ChartContent {
    var position: Point3D { get }
    var anchor: BoundsAnchor? { get }
    var rotation: Rotation3D? { get }

    var pose: Pose3D { get }
}

public extension Posed {
    var pose: Pose3D {
        let anchorPoint = anchor?.anchorPoint(in: bounds) ?? .zero
        return Pose3D(
            position: position - anchorPoint,
            rotation: rotation ?? .identity
        )
    }

    var frame: Rect3D? {
        bounds?.applying(pose)
    }

    var containedFrame: Rect3D? {
        containedBounds?.applying(pose)
    }

    func updateEnityPose(_ entity: Entity) throws {
        let pose = pose

        let transform3D = AffineTransform3D(
            rotation: pose.rotation,
            translation: pose.position.asVector
        )
        entity.transform = Transform(transform3D)
    }
}

// MARK: - Poseable

public protocol Poseable: Posed {
    var position: Point3D { get set }
    var anchor: BoundsAnchor? { get set }
    var rotation: Rotation3D? { get set }
}

public extension Poseable {
    func withPosition(_ position: Point3D) -> Self {
        modify(self) { $0.position = position }
    }

    func withAnchor(_ anchor: BoundsAnchor?) -> Self {
        modify(self) { $0.anchor = anchor }
    }

    func withRotation(_ rotation: Rotation3D?) -> Self {
        modify(self) { $0.rotation = rotation }
    }
}

// MARK: - NotPosed

public protocol NotPosed: ChartContent {}

public extension NotPosed {
    var frame: Rect3D? { bounds }
    var containedFrame: Rect3D? { containedBounds }
}
