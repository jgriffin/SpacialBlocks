//
// Created by John Griffin on 4/18/24
//

import Spatial

public extension RealityContent {
    func frame(
        width: Double? = nil,
        height: Double? = nil,
        depth: Double? = nil,
        alignment: Alignment3D = .center
    ) -> some RealityContent {
        RealityFrame(
            width: width,
            height: height,
            depth: depth,
            alignment: alignment,
            content: self
        )
    }

    func frame(
        size: Size3D,
        alignment: Alignment3D = .center
    ) -> some RealityContent {
        RealityFrame(
            width: size.width,
            height: size.height,
            depth: size.depth,
            alignment: alignment,
            content: self
        )
    }
}
