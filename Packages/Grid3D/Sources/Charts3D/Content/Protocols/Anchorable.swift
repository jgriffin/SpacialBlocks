//
// Created by John Griffin on 4/6/24
//

import Foundation
import Spatial

public protocol Anchorable: Positioned {
    var positionAnchor: BoundsAnchor? { get set }
}

public extension Anchorable {
    func withAnchor(_ anchor: BoundsAnchor) -> Self {
        copy(self) { $0.positionAnchor = anchor }
    }
}
