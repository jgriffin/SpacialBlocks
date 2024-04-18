//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public class RealityContentRenderer {
    public let root = Entity()

    public init() {}

    public func update(
        with content: any RealityContent,
        size: Size3D
    ) {
        let renderTree = Self.renderTreeFor(content, size: size)
        Self.syncEntityTree(root, withRenderTree: renderTree)
    }
}

public extension RealityContentRenderer {
    static func renderTreeFor(
        _ content: any RealityContent,
        size: Size3D
    ) -> RenderNode {
        let context = RenderContext(environment: .init())
        let contentSize = content.sizeFor(size)
        return content.render(context, size: contentSize)
    }

    static func syncEntityTree(
        _ parent: Entity,
        withRenderTree root: RenderNode
    ) {
        parent.children.removeAll()

        let rootEntity = root.renderer.makeEntity()
        parent.addChild(rootEntity)

        for child in root.children {
            syncEntityTree(rootEntity, withRenderTree: child)
        }
    }
}
