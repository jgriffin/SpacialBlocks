//
// Created by John Griffin on 4/22/24
//

import Charts3D
import XCTest

final class PlottableMarksTests: XCTestCase {
    func testPointMark() {
        let point = PointMark(.init(xyz: 1, 2, 3))

        let result = point.dimensionDomains()
        let xDomains = result.x.domains(Int.self)
        let yDomains = result.y.domains(Int.self)
        let zDomains = result.z.domains(Int.self)

        XCTAssertEqual(xDomains.count, 1)
        XCTAssertEqual(yDomains.count, 1)
        XCTAssertEqual(zDomains.count, 1)

        XCTAssertEqual(xDomains.first?.values, [1])
        XCTAssertEqual(yDomains.first?.values, [2])
        XCTAssertEqual(zDomains.first?.values, [3])
    }

    func testPointsMark() {
        let chart = Chart3D {
            PointMark(.init(xyz: 1, 2, 3))
            PointMark(.init(xyz: 4, 5, 6))
        }

        let result = chart.dimensionDomains()
        let xDomains = result.x.domains(Int.self)
        let yDomains = result.y.domains(Int.self)
        let zDomains = result.z.domains(Int.self)

        XCTAssertEqual(xDomains.count, 1)
        XCTAssertEqual(yDomains.count, 1)
        XCTAssertEqual(zDomains.count, 1)

        XCTAssertEqual(xDomains.first?.values, [1, 4])
        XCTAssertEqual(yDomains.first?.values, [2, 5])
        XCTAssertEqual(zDomains.first?.values, [3, 6])
    }

    func testLineMark() {
        let point = LineMark(.init(xyz: 1, 2, 3))

        let result = point.dimensionDomains()
        let xDomains = result.x.domains(Int.self)
        let yDomains = result.y.domains(Int.self)
        let zDomains = result.z.domains(Int.self)

        XCTAssertEqual(xDomains.count, 1)
        XCTAssertEqual(yDomains.count, 1)
        XCTAssertEqual(zDomains.count, 1)

        XCTAssertEqual(xDomains.first?.values, [1])
        XCTAssertEqual(yDomains.first?.values, [2])
        XCTAssertEqual(zDomains.first?.values, [3])
    }
}
