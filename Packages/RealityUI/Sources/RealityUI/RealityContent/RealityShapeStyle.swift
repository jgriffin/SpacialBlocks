//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShapeStyle: RealityContent {
    var name: String { get }
    func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func mesh(in size: Size3D) -> MeshResource
}

public extension RealityShapeStyle {
    var body: some RealityContent {
        RealityShapeView(shape: self, material: .color(.blue))
    }
}

public struct RealityShapeView<S: RealityShapeStyle>: RealityContent, BuiltIn {
    public var shape: S
    public var material: RealityMaterial

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func customRender(_: RenderContext, size: Size3D) -> RealityRenderNode {
        MeshEntity(
            mesh: shape.mesh(in: customSizeFor(.init(size))),
            material: material,
            name: shape.name
        )
        .asNode()
    }
}
