//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShape: RealityContent {
    func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D

    func mesh(in size: Size3D) -> MeshResource
}

public extension RealityShape {
    @RealityBuilder var body: some RealityContent {
        RealityShapeView(shape: self, material: .color(.blue))
    }
}

public struct RealityShapeView<S: RealityShape>: RealityContent, BuiltIn {
    public var shape: S
    public var material: RealityMaterial

    public func sizeFor(_ proposed: ProposedSize3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func render(_: RenderContext, size: Size3D) -> RenderNode {
        RenderNode(
            MeshEntityRenderer(
                mesh: shape.mesh(in: sizeFor(.init(size: size))),
                material: material
            )
        )
    }
}

// MARK: - shapes

public struct BoxShape: RealityShape {
    public init() {}

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.orDefault
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct SphereShape: RealityShape {
    public init() {}

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        Size3D.one * proposed.orDefault.vector.min()
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min() / 2))
    }
}
