//
// Created by John Griffin on 4/21/24
//

import Foundation

public struct PointMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent {
    let point: PlottablePointValue<X, Y, Z>
}

public struct LineMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent {
    let point: PlottablePointValue<X, Y, Z>
}

public struct BarMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent {
    let size: PlottableSizeValue<X, Y, Z>
}

public struct BoxMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent {
    let center: PlottablePointValue<X, Y, Z>
    let size: PlottableSizeValue<X, Y, Z>
}
