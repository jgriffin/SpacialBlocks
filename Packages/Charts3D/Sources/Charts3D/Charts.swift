//
// Created by John Griffin on 4/5/24
//

import Foundation
import Spatial

public enum Charts {}

public extension Charts {
    static let defaultChartMinRange: Rect3D = .init(origin: .zero, size: .one)
    static let defaultSize: Size3D = .one * 1
    static let defaultLineWidth: Float = 0.01

    static let defaultRenderScale: Size3D = .one / 10
    static let defaultGridSize: Size3D = defaultSize
    static let defaultGridThickness: Size3D = .one * 0.001
    static let boundingBoxLineWidth: Float = 0.001
}

public extension ChartMaterial {
    static let defaultMaterial = ChartMaterial.color(.blue)

    static let boundingBox = ChartMaterial.color(.cyan, alpha: 0.1)
    static let boundingBoxLine = ChartMaterial.color(.cyan, alpha: 0.5)
    static let gridPlane = ChartMaterial.color(.cyan, alpha: 0.2)
    static let gridLine = ChartMaterial.color(.cyan, alpha: 0.8)
    static let axisLine = ChartMaterial.color(.cyan, alpha: 0.8)
}
