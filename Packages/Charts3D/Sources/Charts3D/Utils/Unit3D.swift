//
// Created by John Griffin on 4/7/24
//

import Foundation
import Spatial

public struct Unit3D: Hashable {
    public var x: Double
    public var y: Double
    public var z: Double

    @inlinable public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    @inlinable public init(_ x: Double, _ y: Double, _ z: Double) {
        self.init(x: x, y: y, z: z)
    }

    var asVector: Vector3D { Vector3D(x: x, y: y, z: z) }
    var asSize: Size3D { Size3D(asVector) }
    var vector: SIMD3<Double> { [x, y, z] }

    public static let zero = Unit3D(0, 0, 0)
    public static let center = Unit3D(0.5, 0.5, 0.5)
    public static let bottom = Unit3D(0.5, 0, 0.5)
    public static let bottomBack = Unit3D(0.5, 0, 0)
    public static let bottomFront = Unit3D(0.5, 0, 1)
    public static let bottomLeading = Unit3D(0, 0, 0.5)
    public static let bottomLeadingBack = Unit3D(0, 0, 0)
    public static let bottomLeadingFront = Unit3D(0, 0, 1)
    public static let bottomTrailing = Unit3D(1, 0, 0.5)
    public static let bottomTrailingBack = Unit3D(1, 0, 0)
    public static let bottomTrailingFront = Unit3D(1, 0, 1)
    public static let leading = Unit3D(0, 0.5, 0.5)
    public static let leadingBack = Unit3D(0, 0.5, 0)
    public static let leadingFront = Unit3D(0, 0.5, 1)
    public static let top = Unit3D(0.5, 1, 0.5)
    public static let topBack = Unit3D(0.5, 1, 0)
    public static let topFront = Unit3D(0.5, 1, 1)
    public static let topLeading = Unit3D(0, 1, 0.5)
    public static let topLeadingBack = Unit3D(0, 1, 0)
    public static let topLeadingFront = Unit3D(0, 1, 1)
    public static let topTrailing = Unit3D(1, 1, 0.5)
    public static let topTrailingBack = Unit3D(1, 1, 0)
    public static let topTrailingFront = Unit3D(1, 1, 1)
    public static let trailing = Unit3D(1, 0.5, 0.5)
    public static let trailingBack = Unit3D(1, 0.5, 0)
    public static let trailingFront = Unit3D(1, 0.5, 1)
    public static let back = Unit3D(0.5, 0.5, 0)
    public static let front = Unit3D(0.5, 0.5, 1)
}
