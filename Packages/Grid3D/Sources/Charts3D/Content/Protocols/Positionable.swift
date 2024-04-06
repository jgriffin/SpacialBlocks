//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - positioned

public protocol Positioned: Posed {
    var position: Point3D { get }
    var anchorOffset: Vector3D { get }
    var rotation: Rotation3D { get }
}

public extension Positioned {
    var position: Point3D { .zero }

    // relative to entity center
    var anchorOffset: Vector3D { .zero }

    var rotation: Rotation3D { .identity }

    var pose: Pose3D {
        .init(
            position: position - anchorOffset,
            rotation: rotation
        )
    }
}

// MARK: - positionable

public protocol Positionable: Positioned {
    var position: Point3D { get set }
}

public extension Positionable {
    func withPosition(_ position: Point3D) -> Self {
        copy(self) { $0.position = position }
    }
}

// MARK: - anchor offsettable

public protocol AnchorOffsettable: Positioned {
    var anchorOffset: Vector3D { get set }
}

public extension AnchorOffsettable {
    func withAnchorOffset(_ anchorOffset: Vector3D) -> Self {
        copy(self) { $0.anchorOffset = anchorOffset }
    }
}

// MARK: - SizeAnchorablePositionableContent

public protocol SizeAnchorable: Positioned {
    var size: Size3D { get }

    // 0...1 ratio mapped to size.center
    var unitAnchorInSize: Vector3D { get set }
}

public extension SizeAnchorable {
    var anchorOffset: Vector3D {
        (unitAnchorInSize - .half).scaled(by: size)
    }

    // MARK: modifiers

    func withUnitAnchorInSize(_ unitAnchorInSize: Vector3D) -> Self {
        copy(self) { $0.unitAnchorInSize = unitAnchorInSize }
    }
}

// MARK: - Rotatable

public protocol Rotateable: Positioned {
    var rotation: Rotation3D { get set }
}

public extension Rotateable {
    func withRotation(_ rotation: Rotation3D) -> Self {
        copy(self) { $0.rotation = rotation }
    }
}
