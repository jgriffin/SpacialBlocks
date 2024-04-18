//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShape: RealityView {
    func mesh(in size: Size3D) -> MeshResource

    func shapeSizeFor(_ proposed: ProposedSize) -> Size3D
}

public extension RealityShape {
    var body: some RealityView {
        RealityShapeView(shape: self, material: .color(.blue))
    }
}

public struct RealityShapeView<S: RealityShape>: RealityView, BuiltIn {
    public var shape: S
    public var material: RealityMaterial

    public func sizeFor(_ proposed: ProposedSize) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func render(_: RenderContext, size: Size3D) -> RenderNode {
        RenderNode(
            renderer: MeshEntityRenderer(
                mesh: shape.mesh(in: sizeFor(size)),
                material: material
            ),
            children: []
        )
    }
}

// MARK: - shapes

public struct BoxShape: RealityShape {
    public init() {}

    public func shapeSizeFor(_ proposed: ProposedSize) -> Size3D {
        proposed
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct SphereShape: RealityShape {
    public init() {}

    public func shapeSizeFor(_ proposed: ProposedSize) -> Size3D {
        Size3D.one * proposed.vector.min()
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min()))
    }
}
