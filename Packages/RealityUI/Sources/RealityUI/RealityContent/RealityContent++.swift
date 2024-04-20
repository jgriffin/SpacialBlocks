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
            content: self,
            width: width,
            height: height,
            depth: depth,
            alignment: alignment
        )
    }

    func frame(
        size: Size3D,
        alignment: Alignment3D = .center
    ) -> some RealityContent {
        RealityFrame(
            content: self,
            width: size.width,
            height: size.height,
            depth: size.depth,
            alignment: alignment
        )
    }

    func padding(_ insets: EdgeInsets3D) -> some RealityContent {
        RealityPadding(content: self, edgeInsets: insets)
    }

    func padding(_ all: Double) -> some RealityContent {
        RealityPadding(content: self, edgeInsets: .init(all: all))
    }
}
