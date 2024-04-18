// 
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShape: RealityView {
    func mesh(in size: Size3D) -> MeshResource
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
        proposed
    }

    public func render(_ context: RenderContext, size: Size3D) {
        // TODO:
    }
}

// MARK: - shapes

public struct Box: RealityShape {
    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct Sphere: RealityShape {
    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min()))
    }
}
