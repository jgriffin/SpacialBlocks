//
// Created by John Griffin on 4/1/24
//

import RealityKit
import SpacialBlocks
import XCTest

final class Grid3DMathTests: XCTestCase {
//    func testSIMDRemainder() {
//        let tests: [(t: SIMD3<Float>, check: SIMD3<Float>)] = [
//            ([0, 0, 0], [0, 0, 0]),
//            ([0.5, 0.5, 0.5], [1.5, 1.5, 1.5])
//        ]
//        for test in tests {
//            let result = remainder(test.t, [2, 2, 2])
//            XCTAssertEqual(result, test.check)
//        }
//    }
//
//    func testEvenPaddedBounds() {
//        let tests: [(c: Grid3D.UnitsConstraints, check: BoundingBox)] = [
//            (.init(min: [0, 0, 0], max: [1, 1, 1]), .init(min: [0, 0, 0], max: [2, 2, 2]))
//        ]
//
//        for test in tests {
//            let result = test.c.evenPaddedBounds
//            XCTAssertEqual(result, test.check)
//        }
//    }
}

private extension Grid3D.UnitsConstraints {
    init(min: SIMD3<Float>, max: SIMD3<Float>, pad: SIMD3<Float> = [0, 0, 0]) {
        self.init(requiredUnits: .init(min: min, max: max), paddingUnits: pad)
    }
}
