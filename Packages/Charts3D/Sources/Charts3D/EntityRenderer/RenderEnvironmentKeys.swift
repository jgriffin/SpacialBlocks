//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension RenderEnvironment {
    var chartBounds: Rect3D? {
        get { self[ChartBounds.self] }
        set { self[ChartBounds.self] = newValue }
    }
}

// MARK: - environment keys

public struct ChartBounds: RenderEnvironmentKey {
    public static var defaultValue: Rect3D?
}
