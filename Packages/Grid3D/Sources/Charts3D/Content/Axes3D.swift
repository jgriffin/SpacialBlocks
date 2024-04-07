//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public struct Axes3D: ChartContent, EntityRepresentable, HasContents {
    public var gridSize: Size3D
    public var thickness: Size3D

    public init(
        gridSize: Size3D = Charts.defaultGridSize,
        thickness: Size3D = Charts.defaultGridThickness
    ) {
        self.gridSize = gridSize
        self.thickness = thickness
    }

    // MARK: Bounded

    public var bounds: Rect3D? { nil }
    public var containedBounds: Rect3D? { nil }

    // MARK: ContentContaining

    public func contentsFor(
        _ environment: RenderEnvironment?
    ) -> [ChartContent] {
        guard let chartBounds = environment?[ChartBounds.self] else {
            return []
        }

        return makeGridPlanes(chartBounds: chartBounds)
    }

    @ChartBuilder
    private func makeGridPlanes(chartBounds: Rect3D) -> [ChartContent] {
        let chartSize = chartBounds.size

        let _ = print(chartBounds)
        Box3D(size: chartSize,
              position: Point3D(chartBounds.size.vector / 2),
              anchor: .center,
              material: .simple(color: .yellow.withAlphaComponent(0.2), roughness: 0, isMetalic: false))

        // ground
//        GridPlane(
//            size: copy(chartSize, with: { $0.height = thickness.height }),
//            position: .zero // copy(.zero, with: { $0.y = -chartSize.height / 2 })
//        )
//        // back
//        GridPlane(
//            size: copy(chartSize, with: { $0.depth = thickness.depth }),
//            position: chartBounds.center // copy(.zero, with: { $0.z = chartSize.depth / 2 })
//        )
//        // right
//        GridPlane(
//            size: copy(chartSize, with: { $0.width = thickness.width }),
//            position: chartBounds.center // copy(.zero, with: { $0.x = chartSize.width / 2 })
//        )
    }

    // MARK: - modifiers

    func withGridSize(_ gridSize: Size3D) -> Self {
        copy(self) { $0.gridSize = gridSize }
    }
}

public struct GridPlane: ChartContent, EntityRepresentable, Positionable, Sizeable, HasContents {
    public var size: Size3D
    public var position: Point3D
    public var gridSize: Size3D = Charts.defaultGridSize

    public var bounds: Rect3D? {
        nil
    }

    public func contentsFor(_: RenderEnvironment?) -> [ChartContent] {
        makeContents()
    }

    @ChartBuilder
    func makeContents() -> [ChartContent] {
        Box3D(size: size, material: .gridPlane)
    }
}

// public struct GridLine: MeshMaterialRepresentableContent, Sizeable, Positioned {
//    public var size: Size3D
//    public var gridSize: Size3D = Charts.defaultGridSize
//    public var position: Point3D
//
// }
