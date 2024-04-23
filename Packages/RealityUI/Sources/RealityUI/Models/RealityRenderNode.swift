//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RealityRenderNode

public struct RealityRenderNode {
    public init(_ renderer: any EntityRenderer, children: [RealityRenderNode] = []) {
        self.renderer = renderer
        self.children = children
    }

    public var renderer: any EntityRenderer
    public var children: [RealityRenderNode]
}

public extension RealityRenderNode {
    func wrappedIn(_ renderer: any EntityRenderer) -> RealityRenderNode {
        RealityRenderNode(renderer, children: [self])
    }

    func wrappedInTransform(_ transform: AffineTransform3D) -> RealityRenderNode {
        wrappedIn(TransformEntity(transform))
    }

    func wrappedInTranslation(_ translation: Vector3D) -> RealityRenderNode {
        wrappedIn(TransformEntity(translation: translation))
    }

    func wrappedInAlignment(_ alignment: Alignment3D, parent: Size3D, child: Size3D) -> RealityRenderNode {
        wrappedIn(TransformEntity(alignment: alignment.offset(parent: parent, child: child)))
    }
}
