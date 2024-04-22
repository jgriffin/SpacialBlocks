//
// Created by John Griffin on 4/21/24
//

import Foundation

public protocol PlottableMark {}

public struct PointMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
    public let point: PlottableValuePoint<X, Y, Z>

    public init(_ point: PlottableValuePoint<X, Y, Z>) {
        self.point = point
    }

    public init(x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>) {
        self.init(.init(x: x, y: y, z: z))
    }

    public func customDimensionDomains() -> DimensionDomains {
        DimensionDomains(
            x: .init(point.x),
            y: .init(point.y),
            z: .init(point.z)
        )
    }

    public func customRender() {}
}

public struct LineMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
    let point: PlottableValuePoint<X, Y, Z>

    public init(_ point: PlottableValuePoint<X, Y, Z>) {
        self.point = point
    }

    public init(x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>) {
        self.init(.init(x: x, y: y, z: z))
    }

    public func customDimensionDomains() -> DimensionDomains {
        DimensionDomains(
            x: .init(point.x),
            y: .init(point.y),
            z: .init(point.z)
        )
    }

    public func customRender() {}
}

// public struct BarMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
//    let size: PlottableValueSize<X, Y, Z>
//
//    public init(_ size: PlottableValueSize<X, Y, Z>) {
//        self.size = size
//    }
//
//    public init(width: PlottableValue<X>, height: PlottableValue<Y>, depth: PlottableValue<Z>) {
//        self.init(.init(width: width, height: height, depth: depth))
//    }
//
//    public func customDimensionDomains() -> DimensionDomains {
//        DimensionDomains(
//            x: .init(size.width),
//            y: .init(size.height),
//            z: .init(size.depth)
//        )
//    }
//
//    public func customRender() {}
// }

// public struct BoxMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
//    let min, max: PlottableValuePoint<X, Y, Z>
//
//    public init(_ points: PlottableValuePoint<X, Y, Z>) {
//
//    }
//
//    public func customDimensionDomains() -> DimensionDomains {
//        DimensionDomains(
//            x: .init(size.width),
//            y: .init(size.height),
//            z: .init(size.depth)
//        )
//    }
//
//    public func customRender() {}
// }
