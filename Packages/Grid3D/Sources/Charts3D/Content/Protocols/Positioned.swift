//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - Positioned

public protocol Positioned: Posed {
    var position: Point3D { get }
    var positionAnchor: BoundsAnchor { get }
    var rotation: Rotation3D { get }
}

public extension Positioned {
    // MARK: - default implementations

    var position: Point3D { .zero }
    var positionAnchor: BoundsAnchor { .init() }
    var rotation: Rotation3D { .identity }

    // MARK: - anchor position

    var pose: Pose3D {
        let bounds = (self as? Bounded)?.bounds
        let anchorPoint = positionAnchor.anchorPoint(in: bounds)
        return Pose3D(
            position: position - anchorPoint,
            rotation: rotation
        )
    }
}

// MARK: - Positionable

public protocol Positionable: Positioned {
    var position: Point3D { get set }
}

public extension Positionable {
    func withPosition(_ position: Point3D) -> Self {
        copy(self) { $0.position = position }
    }
}

//// MARK: - SizeAnchored
//
// public protocol SizeAnchored: Positioned, Sized {
//    // 0...1 ratio mapped to size.center
//    var unitAnchorInSize: Vector3D { get }
// }
//
// public extension SizeAnchorable {
//    var positionAnchorOffset: Vector3D {
//        (unitAnchorInSize - .half).scaled(by: size)
//    }
// }
//
//// MARK: - SizeAnchorable
//
// public protocol SizeAnchorable: SizeAnchored {
//    // 0...1 ratio mapped to size.center
//    var unitAnchorInSize: Vector3D { get set }
// }
//
// public extension SizeAnchorable {
//    // MARK: modifiers
//
//    func withUnitAnchorInSize(_ unitAnchorInSize: Vector3D) -> Self {
//        copy(self) { $0.unitAnchorInSize = unitAnchorInSize }
//    }
// }

// MARK: - Rotatable

public protocol Rotateable: Positioned {
    var rotation: Rotation3D { get set }
}

public extension Rotateable {
    func withRotation(_ rotation: Rotation3D) -> Self {
        copy(self) { $0.rotation = rotation }
    }
}
