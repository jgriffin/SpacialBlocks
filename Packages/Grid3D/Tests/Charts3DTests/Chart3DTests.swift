//
// Created by John Griffin on 4/4/24
//

import Spatial
import SpatialCharts
import XCTest

final class Chart3DTests: XCTestCase {
    func testEmptyChart() {
        let result = Chart3D(contents: [])
        XCTAssertNil(result.bounds)
        XCTAssertTrue(result.contents.isEmpty)
    }

    func testChartBounds() {
        let result = Chart3D(contents: [])
            .bounds(.init(origin: Point3D.zero, size: .one))
        XCTAssertNotNil(result.bounds)
    }
}
