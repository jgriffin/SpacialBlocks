//
// Created by John Griffin on 4/6/24
//

import Foundation
import Spatial
import XCTest

final class Rect3DTests: XCTestCase {
    let fiveFiveFive: SIMD3<Float> = [5.0, 5.0, 5.0]

    func testRect3D() {
        let tests: [(test: Rect3D, checkMin: Point3D, checkMax: Point3D)] = [
            (
                Rect3D(origin: Point3D.zero, size: Size3D(fiveFiveFive)),
                checkMin: Point3D.zero,
                checkMax: Point3D(fiveFiveFive)
            ),
            (
                Rect3D(origin: Point3D(-fiveFiveFive), size: Size3D(fiveFiveFive)),
                checkMin: Point3D(-fiveFiveFive),
                checkMax: Point3D.zero
            ),
            (
                Rect3D(center: Point3D.zero, size: Size3D(fiveFiveFive)),
                checkMin: Point3D(-fiveFiveFive / 2),
                checkMax: Point3D(fiveFiveFive / 2)
            ),
            (
                Rect3D(points: [Point3D(fiveFiveFive)]),
                checkMin: Point3D(fiveFiveFive),
                checkMax: Point3D(fiveFiveFive)
            ),
        ]

        for test in tests {
            XCTAssertEqual(test.test.min, test.checkMin)
            XCTAssertEqual(test.test.max, test.checkMax)
        }
    }

    func testUnionEmpty() {
        let one = Rect3D(center: .zero, size: .one)
        let point = Rect3D(center: .one * 2.0, size: .zero)

        let result = one.union(point)

        XCTAssertEqual(result, Rect3D(min: .one * -0.5, max: .one * 2.0))
    }
}
