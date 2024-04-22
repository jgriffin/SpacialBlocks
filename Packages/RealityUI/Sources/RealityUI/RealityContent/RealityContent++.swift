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

    func aspectRatio(
        _ ratio: Size3D? = nil,
        maxScale: Double? = nil,
        contentMode: ContentMode = .fit
    ) -> some RealityContent {
        RealityAspectRatio(content: self, aspectRatio: ratio, maxScale: maxScale, contentMode: contentMode)
    }

    func scaledToFit() -> some RealityContent { aspectRatio(maxScale: 1) }
}

public enum ContentMode {
    case fit // , fill
}
