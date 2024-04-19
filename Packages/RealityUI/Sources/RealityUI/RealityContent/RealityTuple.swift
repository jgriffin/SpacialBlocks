//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct RealityTuple<each Content: RealityContent>: RealityContent, BuiltIn {
    let value: (repeat each Content)

    public init(_ value: repeat each Content) {
        self.value = (repeat each value)
    }

    public var asContents: [any RealityContent] {
        var contents: [any RealityContent] = []
        repeat contents.append(each value as any RealityContent)
        return contents
    }

    public func sizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.orDefault
    }

    public func render(_: RenderContext, size _: Size3D) -> RenderNode {
        .init(EmptyEntityRenderer())
    }
}
