//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - positioned

public protocol PositionedContent: TransformableContent {
    var position: Point3D { get }
    var anchorOffset: Vector3D { get }
}

public extension PositionedContent {
    var position: Point3D { .zero }

    // relative to entity center
    var anchorOffset: Vector3D { .zero }

    var transform: Pose3D {
        .init(
            position: position - anchorOffset,
            rotation: .identity
        )
    }
}

// MARK: - positionable

public protocol PositionableContent {
    var position: Point3D { get set }
    var anchorOffset: Vector3D { get set }
}

public extension PositionableContent {
    func withPosition(_ position: Point3D) -> Self {
        copyWith(self) { $0.position = position }
    }

    func withAnchorOffset(_ anchorOffset: Vector3D) -> Self {
        copyWith(self) { $0.anchorOffset = anchorOffset }
    }
}
