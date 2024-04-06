//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public struct Chart3DAxes: EntityRepresentableContent, Chart3DContentContainer {
    public var gridSize: Size3D

    public func childrenForRender(_ environment: RenderEnvironment) -> (RenderEnvironment, [any EntityRepresentableContent])? {
        guard let chartRange = environment[ChartRange.self] else {
            return nil
        }
        let chartSize = chartRange.size

        let gridPlanes = [
            Chart3DGridPlane(
                size: .init(width: chartSize.width, height: 0.01, depth: chartSize.height),
                gridSize: gridSize,
                anchorOffset: .init(x: chartRange.center.x, y: chartRange.min.y, z: chartRange.center.z)
            ),
        ]

        return (environment, gridPlanes)
    }
}

public struct Chart3DGridPlane: MeshMaterialRepresentableContent, SizeableContent, PositionedContent {
    public var size: Size3D
    public var gridSize: Size3D
    public var anchorOffset: Vector3D

    public func makeMesh() -> MeshResource {
        .generateBox(size: .init(size))
    }

    public var material: Chart3DMaterial?
}
