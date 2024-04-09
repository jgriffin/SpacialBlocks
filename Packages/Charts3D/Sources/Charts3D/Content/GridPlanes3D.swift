//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public struct GridPlanes3D: ChartContent, EntityRepresentable, NotPosed {
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

    // MARK: - modifiers

    func withGridSize(_ gridSize: Size3D) -> Self {
        modify(self) { $0.gridSize = gridSize }
    }
}

public extension GridPlanes3D {
    func contentsFor(
        _ environment: RenderEnvironment?
    ) -> [ChartContent] {
        guard let chartBounds = environment?[ChartBounds.self] else { return [] }

        return makeGridPlanes(chartBounds: chartBounds)
    }

    @ChartBuilder
    private func makeGridPlanes(chartBounds: Rect3D) -> [ChartContent] {
        Sphere3D(radius: 0.04, position: .zero, material: .color(.red, alpha: 0.8))

        axisLine(to: modify(.zero) { $0.x = chartBounds.max.x })
        axisLine(to: modify(.zero) { $0.y = chartBounds.max.y })
        axisLine(to: modify(.zero) { $0.z = chartBounds.max.z })

        // ground
        gridPlane(u: .right * chartBounds.size.width,
                  v: .forward * chartBounds.size.depth,
                  center: chartBounds.unitPoint(.bottom))
        // back
        gridPlane(u: .right * chartBounds.size.width,
                  v: .up * chartBounds.size.height,
                  center: chartBounds.unitPoint(.back))
        // right
        gridPlane(u: .forward * chartBounds.size.depth,
                  v: .up * chartBounds.size.height,
                  center: chartBounds.unitPoint(.trailing))
        
        let _: Void = print("GridPlane chartBounds: \(chartBounds)")
//        BoundingBox(chartBounds)
    }

    func axisLine(from _: Point3D = .zero, to: Point3D) -> some ChartContent {
        Line3D(from: .zero, to: to, material: .axisLine)
    }

    func gridPlane(u: Vector3D, v: Vector3D, center: Point3D) -> some ChartContent {
        Plane3D(u: u, v: v, position: center, anchor: .center, material: .gridPlane)
    }
}
