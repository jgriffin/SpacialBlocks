//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public enum Renderer {
    public static func renderTreeFor(_ root: any RealityView, size: Size3D) -> RenderNode {
        let context = RenderContext(environment: .init())
        return root.render(context, size: size)
    }

    public static func syncEntityTree(_ parent: Entity, withRenderTree root: RenderNode) {
        parent.children.removeAll()

        let rootEntity = root.renderer.makeEntity()
        root.renderer.updateEntity(rootEntity)
        parent.addChild(rootEntity)

        for child in root.children {
            syncEntityTree(rootEntity, withRenderTree: child)
        }
    }
}
