//
// Created by John Griffin on 4/4/24
//

import Spatial

public extension Vector3D {
    static let half = Vector3D([0.5, 0.5, 0.5])
    static let zFlip = Vector3D([1.0, 1.0, -1.0])

    var flipZ: Vector3D { Vector3D(vector * .zFlip) }
}

public extension Point3D {
    var asVector: Vector3D { Vector3D(self) }

    static let one = Point3D(.one)
}

public extension Size3D {
    var asCenterRect: Rect3D {
        Rect3D(center: .zero, size: size)
    }
}

public extension Rect3D {
    init(min: Point3D = .zero, max: Point3D) {
        self.init(points: [min, max])
    }

    func unitPoint(_ point: Unit3D) -> Point3D {
        min + size.scaled(by: point.asSize)
    }

    static func union(_ rects: [Rect3D]) -> Rect3D? {
        rects.reduce(nil as Rect3D?) { result, next in
            result?.union(next) ?? next
        }
    }
}

public extension SIMD3<Float> {
    static let half: Self = [0.5, 0.5, 0.5]
    static let zFlip: Self = [1.0, 1.0, -1.0]

    var flipZ: Self { self * .zFlip }
}

public extension SIMD3<Double> {
    static let half: Self = [0.5, 0.5, 0.5]
    static let zFlip: Self = [1.0, 1.0, -1.0]

    var flipZ: Self { self * .zFlip }
}
