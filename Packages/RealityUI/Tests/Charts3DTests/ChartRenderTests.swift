//
// Created by John Griffin on 4/22/24
//

import Charts3D
import RealityUI
import XCTest

final class ChartRenderTests: XCTestCase {
    func testEmpty() {
        let chart = Chart3D {}
        let result = chart.render(ChartEnvironment())

        XCTAssert(type(of: result) == EmptyContent.self)
    }

    func testPoint() {
        let chart = Chart3D {
            PointMark(("x", "y", "z"), (0, 0, 0))
        }
        let result = chart.render(ChartEnvironment())

        print(result)
    }
}
