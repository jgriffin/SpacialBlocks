//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public struct GridPlanes3D: ChartContent, EntityRepresentable, HasContents {
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
        copy(self) { $0.gridSize = gridSize }
    }

    // MARK: ContentContaining

    public func contentsFor(
        _ environment: RenderEnvironment?
    ) -> [ChartContent] {
        guard let chartBounds = environment?[ChartBounds.self] else { return [] }

        return makeGridPlanes(chartBounds: chartBounds)
    }

    @ChartBuilder
    private func makeGridPlanes(chartBounds: Rect3D) -> [ChartContent] {
        let _: Void = print(chartBounds)

        Sphere3D(radius: 0.01, position: .zero, material: .simple(color: .red))

        axisLine(to: copy(.zero) { $0.x = chartBounds.max.x })
        axisLine(to: copy(.zero) { $0.y = chartBounds.max.y })
        axisLine(to: copy(.zero) { $0.z = chartBounds.max.z })

        // ground
//        gridPlane(u: .right * chartBounds.size.width,
//                  v: -.forward * chartBounds.size.depth,
//                  center: chartBounds.unitPoint(.bottom))
        // back
        gridPlane(u: .right * chartBounds.size.width,
                  v: .up * chartBounds.size.height,
                  center: chartBounds.unitPoint(.back))
        // right
//        gridPlane(u: .up * chartBounds.size.height,
//                  v: -.forward * chartBounds.size.depth,
//                  center: chartBounds.unitPoint(.trailing))
    }

    func axisLine(from _: Point3D = .zero, to: Point3D) -> some ChartContent {
        Line3D(from: .zero, to: to, material: .axisLine)
    }

    func gridPlane(u: Vector3D, v: Vector3D, center: Point3D) -> some ChartContent {
        Plane3D(u: u, v: v, position: center, anchor: .center, material: .gridPlane)
    }
}

public struct GridPlane: ChartContent, EntityRepresentable, Sized, HasContents {
    public var size: Size3D
    public var position: Point3D
    public var anchor: BoundsAnchor? = .center
    public var gridSize: Size3D = Charts.defaultGridSize

    public func contentsFor(_: RenderEnvironment?) -> [ChartContent] {
        makeContents()
    }

    @ChartBuilder
    func makeContents() -> [ChartContent] {
        Box3D(size: size, anchor: .center, material: .gridPlane)
//        Line3D(from: position - size.scaled(by: UnitPoint3D.leading.asSize),
//               to: position - size.scaled(by: UnitPoint3D.trailing.asSize))
    }
}
