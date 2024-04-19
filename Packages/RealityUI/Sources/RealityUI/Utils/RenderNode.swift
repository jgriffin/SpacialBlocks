//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RenderNode

public struct RenderNode {
    public init(_ renderer: any EntityRenderer, children: [RenderNode] = []) {
        self.renderer = renderer
        self.children = children
    }

    public var renderer: any EntityRenderer
    public var children: [RenderNode]
}

public extension RenderNode {
    func wrappedIn(_ renderer: any EntityRenderer) -> RenderNode {
        RenderNode(renderer, children: [self])
    }

    func wrappedInTransform(_ transform: AffineTransform3D) -> RenderNode {
        wrappedIn(TransformEntity(transform))
    }

    func wrappedInTranslation(_ translation: Vector3D) -> RenderNode {
        wrappedInTransform(.init(translation: translation))
    }

    func wrappedInAlignment(_ alignment: Alignment3D, parent: Size3D, child: Size3D) -> RenderNode {
        wrappedInTranslation(alignment.offset(parent: parent, child: child))
    }
}
