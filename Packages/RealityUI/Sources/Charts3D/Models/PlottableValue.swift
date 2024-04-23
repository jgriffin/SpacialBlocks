//
// Created by John Griffin on 4/21/24
//

import Foundation

// MARK: - Plottable Value

public protocol Plottable {}

public protocol PlottablePrimitive: Plottable {}
extension Double: PlottablePrimitive {}
extension Float: PlottablePrimitive {}
extension Int: PlottablePrimitive {}
extension String: PlottablePrimitive {}

// MARK: - Plottable Value

public struct PlottableValue<Value: Plottable> {
    public let label: String
    public let value: Value

    private init(label: some StringProtocol, value: Value) {
        self.label = .init(label)
        self.value = value
    }

    public static func value(_ label: some StringProtocol, _ value: Value) -> Self {
        .init(label: label, value: value)
    }
}

public struct PlottableValuePoint<X: Plottable, Y: Plottable, Z: Plottable> {
    public let x: PlottableValue<X>
    public let y: PlottableValue<Y>
    public let z: PlottableValue<Z>

    public init(x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public extension PlottableValuePoint {
    init(xyz x: X, _ y: Y, _ z: Z) {
        self.x = .value("x", x)
        self.y = .value("y", y)
        self.z = .value("z", z)
    }
}

public struct PlottableValueSize<X: Plottable, Y: Plottable, Z: Plottable> {
    public let width: PlottableValue<X>
    public let height: PlottableValue<Y>
    public let depth: PlottableValue<Z>

    public init(width: PlottableValue<X>, height: PlottableValue<Y>, depth: PlottableValue<Z>) {
        self.width = width
        self.height = height
        self.depth = depth
    }
}
