//
// Created by John Griffin on 4/5/24
//

import Foundation
import Spatial

public enum Charts {}

public extension Charts {
    static let defaultChartRange: Rect3D = .init(origin: .zero, size: .one * 10.0)
    static let defaultBoxSize: Size3D = .one * 1
    static let defaultBoxUnitAnchor: Vector3D = .zero
    static let defaultRenderScale: Size3D = .one / 10
    static let defaultGridSize: Size3D = defaultBoxSize
    static let defaultGridThickness: Size3D = .one * 0.001
}

public extension ChartMaterial {
    static let defaultMaterial = ChartMaterial.simple(color: .blue.withAlphaComponent(1.0), roughness: 0, isMetalic: false)

    static let gridPlane = ChartMaterial.simple(color: .cyan.withAlphaComponent(0.2), roughness: 1, isMetalic: false)
    static let gridLine = ChartMaterial.simple(color: .cyan.withAlphaComponent(0.8), roughness: 0, isMetalic: false)
}
