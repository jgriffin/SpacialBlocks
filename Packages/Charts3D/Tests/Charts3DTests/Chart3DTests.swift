//
// Created by John Griffin on 4/4/24
//

import Charts3D
import Spatial
import XCTest

final class BoundsTests: XCTestCase {
    let oneTwoThree = Point3D([1.0, 2.0, 3.0])
    let tenTenTen = Point3D([10.0, 10, 10])
    let elevenTwelveThirteen = Point3D([11.0, 12, 13])

    func testBoxBounds() {
        let box = Box3D(
            size: .init(oneTwoThree),
            position: tenTenTen
        )
        XCTAssertEqual(box.bounds?.size, Point(oneTwoThree).size)
        XCTAssertEqual(box.bounds?.min, Point3D(oneTwoThree - 0.5))
        XCTAssertEqual(box.bounds?.max, Point3D(oneTwoThree + 0.5))
        XCTAssertEqual(box.containedBounds?.min, Point3D(tenTenTen))
        XCTAssertEqual(box.containedBounds?.max, Point3D([11.0, 12, 13]))
    }

    func testChartBounds() {
        let chart = Chart3D {
            Box3D(
                size: .init(oneTwoThree),
                position: Point3D(tenTenTen)
            )
        }

        XCTAssertEqual(chart.bounds?.min, Point3D.zero)
        XCTAssertEqual(chart.bounds?.max, Point3D(tenTenTen))
        XCTAssertEqual(chart.containedBounds?.min, Point3D.zero)
        XCTAssertEqual(chart.containedBounds?.max, Point3D(elevenTwelveThirteen))
    }
}
