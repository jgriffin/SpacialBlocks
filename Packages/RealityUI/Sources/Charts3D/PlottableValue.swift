//
// Created by John Griffin on 4/21/24
//

import Foundation

public protocol Plottable {}

public struct PlottableValue<Value: Plottable> {
    let label: String
    let value: Value
}

public struct PlottablePointValue<X: Plottable, Y: Plottable, Z: Plottable> {
    let x: PlottableValue<X>
    let y: PlottableValue<Y>
    let z: PlottableValue<Z>
}

public struct PlottableSizeValue<X: Plottable, Y: Plottable, Z: Plottable> {
    let width: PlottableValue<X>
    let height: PlottableValue<Y>
    let depths: PlottableValue<Z>
}
