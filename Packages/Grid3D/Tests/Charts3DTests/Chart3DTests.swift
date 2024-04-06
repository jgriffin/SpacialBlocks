//
// Created by John Griffin on 4/4/24
//

import Charts3D
import Spatial
import XCTest

final class Chart3DTests: XCTestCase {
    func testEmptyChart() {
        let result = Chart3D {}

        XCTAssertEqual(result.range, Charts.defaultChartRange)
        XCTAssertTrue(result.contents.isEmpty)
    }

    func testChartBounds() {
        let result = Chart3D {}
            .range(.init(origin: Point3D.zero, size: .one))

        XCTAssertNotNil(result.range)
    }
}
