//
// Created by John Griffin on 4/1/24
//

import Grid3D
import RealityKit
import XCTest

final class Grid3DMathTests: XCTestCase {
    typealias PositionFitCheck = (position: SIMD3<Float>, fit: Grid3D.UnitsFit, check: SIMD3<Float>)

    func pfcs(_ tests: PositionFitCheck...) -> [PositionFitCheck] { tests }

    func assertPFCsPreZ(_ pfcs: PositionFitCheck...) {
        for (i, pfc) in pfcs.enumerated() {
            XCTAssertEqual(
                pfc.fit.positionForUnits(pfc.position).flipZ,
                pfc.check,
                "\(pfc.position.desc) \(i + 1)"
            )
        }
    }

    func testPositionForUnits() {
        assertPFCsPreZ(
            (.zero, .init(max: [1, 2, 3]), [-0.5, -1, -1.5]),
            (.zero, .init(min: -[1, 2, 3], max: [1, 2, 3]), .zero),
            (.zero, .init(min: -.one, max: [1, 2, 3]), [0, -0.5, -1])
        )

        assertPFCsPreZ(
            (.one, .init(max: [1, 2, 3]), [0.5, 0, -0.5]),
            (.one, .init(min: -[1, 2, 3], max: [1, 2, 3]), .one),
            (.one, .init(min: -.one, max: [1, 2, 3]), [1, 0.5, 0])
        )

        assertPFCsPreZ(
            (-.one, .init(max: [1, 2, 3]), [-1.5, -2, -2.5]),
            (-.one, .init(min: -[1, 2, 3], max: [1, 2, 3]), -.one),
            (-.one, .init(min: -.one, max: [1, 2, 3]), [-1, -1.5, -2])
        )

        assertPFCsPreZ(
            (2 * .one, .init(max: [1, 2, 3]), [1.5, 1, 0.5]),
            (2 * .one, .init(min: -[1, 2, 3], max: [1, 2, 3]), [2, 2, 2]),
            (2 * .one, .init(min: -.one, max: [1, 2, 3]), [2, 1.5, 1])
        )

        assertPFCsPreZ(
            (-2 * .one, .init(max: [1, 2, 3]), [-2.5, -3, -3.5]),
            (-2 * .one, .init(min: -[1, 2, 3], max: [1, 2, 3]), -2 * .one),
            (-2 * .one, .init(min: -.one, max: [1, 2, 3]), [-2, -2.5, -3])
        )
        
        assertPFCsPreZ(
            ([0,0,0], .init(max: [9,5,6]), [-4.5, -2.5, -3]),
            ([0,0,0], .init(min: [-1,0,0], max: [9,5,6]), [-4, -2.5, -3])
        )

    }

    func testSingle() {
        assertPFCsPreZ(
            (-.one, .init(max: 2), -2 * .one)
        )
    }
}

private extension Grid3D.UnitsFit {
    init(
        min: SIMD3<Float> = .zero,
        max: SIMD3<Float>,
        _ bias: Grid3D.UnitBias = .centerOn
    ) {
        self.init(unitsBounds: .init(min: min, max: max), scale: .one, bias: bias)
    }

    init(
        min: Float = 0,
        max: Float,
        _ bias: Grid3D.UnitBias = .centerOn
    ) {
        self.init(unitsBounds: .init(min: min * .one, max: max * .one), scale: .one, bias: bias)
    }

    init(
        _ bounds: BoundingBox,
        bias: Grid3D.UnitBias = .centerBetween
    ) {
        self.init(unitsBounds: bounds, scale: .one, bias: bias)
    }
}

private extension Grid3D.UnitsConstraints {
    init(
        min: SIMD3<Float>,
        max: SIMD3<Float>,
        padMin: SIMD3<Float> = [0, 0, 0],
        padMax: SIMD3<Float> = [0, 0, 0]
    ) {
        self.init(requiredUnits: .init(min: min, max: max), paddingMin: padMin, paddingMax: padMax)
    }
}
