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
