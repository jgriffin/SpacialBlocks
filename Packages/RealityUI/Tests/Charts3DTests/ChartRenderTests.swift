//
// Created by John Griffin on 4/22/24
//

import Charts3D
import RealityUI
import XCTest

final class ChartRenderTests: XCTestCase {
    func testEmpty() {
        let chart = Chart3D {}
        let result = chart.body
        XCTAssert(type(of: result) == EmptyContent.self)
    }

    func testPoint() {
        let chart = Chart3D {
            PointMark(.init(xyz: 0, 0, 0))
        }
        let result = chart.body
        print(result)
    }
}
