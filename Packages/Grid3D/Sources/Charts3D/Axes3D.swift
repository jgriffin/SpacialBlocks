//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public struct Axes3D: EntityRepresentable, ContentContaining {
    public var gridSize: Size3D
    public var thickness: Size3D

    public init(
        gridSize: Size3D = Charts.defaultGridSize,
        thickness: Size3D = Charts.defaultGridThickness
    ) {
        self.gridSize = gridSize
        self.thickness = thickness
    }

    func withGridSize(_ gridSize: Size3D) -> Self {
        copy(self) { $0.gridSize = gridSize }
    }

    public func contentsFor(
        _ environment: RenderEnvironment
    ) -> (RenderEnvironment, [ChartContent])? {
        guard let range = environment[ChartRange.self] else {
            return nil
        }

        let gridPlanes = makeGridPlanes(range: range).compactMap { $0 as? EntityRepresentable }
        return (environment, gridPlanes)
    }

    @ChartBuilder
    private func makeGridPlanes(range: Rect3D) -> [ChartContent] {
        // X
        GridPlane(
            size: copy(range.size, with: { $0.height = thickness.height }),
            position: copy(range.center, with: { $0.y = range.min.y })
        )
        // Z
        GridPlane(
            size: copy(range.size, with: { $0.depth = thickness.depth }),
            position: copy(range.center, with: { $0.z = range.max.z })
        )
        // Y
        GridPlane(
            size: copy(range.size, with: { $0.width = thickness.width }),
            position: copy(range.center, with: { $0.x = range.max.x })
        )
    }
}

public struct GridPlane: EntityRepresentable, Sizeable, Positioned, ContentContaining {
    public var size: Size3D
    public var position: Point3D
    public var gridSize: Size3D = Charts.defaultGridSize

    public func contentsFor(
        _ environment: RenderEnvironment
    ) -> (RenderEnvironment, [ChartContent])? {
        (environment, makeContents())
    }

    @ChartBuilder
    func makeContents() -> [ChartContent] {
        Box3D(size: size, position: .zero, unitAnchorInSize: .half, material: .gridPlane)
    }
}

// public struct GridLine: MeshMaterialRepresentableContent, Sizeable, Positioned {
//    public var size: Size3D
//    public var gridSize: Size3D = Charts.defaultGridSize
//    public var position: Point3D
//
// }
