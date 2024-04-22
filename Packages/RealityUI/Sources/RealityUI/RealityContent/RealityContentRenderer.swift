//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public class RealityContentRenderer {
    public let realityRoot: Entity

    public init() {
        realityRoot = Entity()
        realityRoot.name = "realityRoot"
    }

    public func update(
        with content: any RealityContent,
        size: Size3D
    ) {
        let renderTree = Self.renderTreeFor(content, size: size)
        Self.syncEntityTree(realityRoot, withRenderTree: renderTree)
    }
}

public extension RealityContentRenderer {
    static func renderTreeFor(
        _ content: any RealityContent,
        size: Size3D
    ) -> RenderNode {
        let context = RenderContext(environment: .init())
        let contentSize = content.sizeThatFits(.init(size))
        return content.render(context, size: contentSize)
    }

    static func syncEntityTree(
        _ parent: Entity,
        withRenderTree node: RenderNode
    ) {
        let nodeEntity = node.renderer.makeEntity()
        nodeEntity.name = "\(type(of: node.renderer))"
        parent.addChild(nodeEntity)

        for child in node.children {
            syncEntityTree(nodeEntity, withRenderTree: child)
        }
    }
}
