//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public struct RenderContext {
    var environment: RealityEnvironment
}

public extension RenderContext {
    func modify(_ transform: (inout RenderContext) -> Void) -> RenderContext {
        RealityUI.modify(self, with: transform)
    }

    func modifyEnvironment(_ transform: (inout RealityEnvironment) -> Void) -> RenderContext {
        modify {
            $0.environment = RealityUI.modify($0.environment, with: transform)
        }
    }
}
