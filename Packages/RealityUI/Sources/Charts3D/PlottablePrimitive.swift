//
// Created by John Griffin on 4/21/24
//

import Foundation

public protocol PlottablePrimitive: Plottable {}
extension Double: PlottablePrimitive {}
extension Float: PlottablePrimitive {}
extension Int: PlottablePrimitive {}
