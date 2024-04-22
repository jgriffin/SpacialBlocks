//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShape: RealityContent {
    var name: String { get }
    func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func mesh(in size: Size3D) -> MeshResource
}

public extension RealityShape {
    var body: some RealityContent {
        RealityShapeView(shape: self, material: .color(.blue))
    }
}

public struct RealityShapeView<S: RealityShape>: RealityContent, BuiltIn {
    public var shape: S
    public var material: RealityMaterial

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func customRender(_: RenderContext, size: Size3D) -> RenderNode {
        MeshEntity(
            mesh: shape.mesh(in: customSizeFor(.init(size))),
            material: material,
            name: shape.name
        )
        .asNode()
    }
}

// MARK: - shapes

public struct BoxShape: RealityShape {
    public init() {}

    public var name = "Box"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct SphereShape: RealityShape {
    public init() {}

    public var name = "Sphere"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        AspectRatioMath.scaledToFit(proposed.sizeOrDefault, aspectRatio: .one, maxScale: nil)
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min() / 2))
    }
}
