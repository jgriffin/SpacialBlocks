//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - Positioned

public protocol Positioned: Posed {
    var position: Point3D { get }
    var anchor: BoundsAnchor? { get }
    var rotation: Rotation3D? { get }
}

public extension Positioned {
    // MARK: - default implementations

    var anchor: BoundsAnchor? { nil }
    var rotation: Rotation3D? { nil }

    // MARK: - anchor position

    var pose: Pose3D {
        let anchorPoint = anchor?.anchorPoint(in: bounds) ?? .zero
        return Pose3D(
            position: position - anchorPoint,
            rotation: rotation ?? .identity
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

// MARK: - Anchorable

public protocol Anchorable: Positioned {
    var anchor: BoundsAnchor? { get set }
}

public extension Anchorable {
    func withAnchor(_ anchor: BoundsAnchor) -> Self {
        copy(self) { $0.anchor = anchor }
    }
}

// MARK: - Rotatable

public protocol Rotateable: Positioned {
    var rotation: Rotation3D? { get set }
}

public extension Rotateable {
    func withRotation(_ rotation: Rotation3D?) -> Self {
        copy(self) { $0.rotation = rotation }
    }
}
