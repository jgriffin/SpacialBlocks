//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

// MARK: - Sizeable

public protocol Sizeable {
    var size: Size3D { get set }
}

public extension Sizeable {
    func withSize(_ size: Size3D) -> Self {
        copy(self) { $0.size = size }
    }
}
