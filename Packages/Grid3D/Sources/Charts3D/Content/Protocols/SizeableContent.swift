//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - Sizeable

public protocol SizeableContent {
    var size: Size3D { get set }
}

public extension SizeableContent {
    func withSize(_ size: Size3D) -> Self {
        copyWith(self) { $0.size = size }
    }
}

// MARK: - SizeAnchorablePositionableContent

public protocol SizeAnchorablePositionableContent: PositionedContent {
    var size: Size3D { get }

    // 0...1 ratio mapped to size.center
    var unitAnchorInSize: Vector3D { get set }
}

public extension SizeAnchorablePositionableContent {
    var anchorOffset: Vector3D {
        (unitAnchorInSize - .half).scaled(by: size)
    }
}

public extension SizeAnchorablePositionableContent {
    func withUnitAnchorInSize(_ unitAnchorInSize: Vector3D) -> Self {
        copyWith(self) { $0.unitAnchorInSize = unitAnchorInSize }
    }
}
