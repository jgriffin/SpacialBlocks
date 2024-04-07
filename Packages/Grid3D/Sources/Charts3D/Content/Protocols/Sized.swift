//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol Sized: Positioned, Bounded {
    var size: Size3D { get }
}

public extension Sized {
    // MARK: - Bounded

    var bounds: Rect3D? {
        Rect3D(center: .zero, size: size)
    }
}

// MARK: - Sizeable

public protocol Sizeable: Sized {
    var size: Size3D { get set }
}

public extension Sizeable {
    // MARK: - modifiers

    func withSize(_ size: Size3D) -> Self {
        copy(self) { $0.size = size }
    }
}
