//
// Created by John Griffin on 4/4/24
//

import Charts3D
import RealityKit
import XCTest

final class EntityRendererTests: XCTestCase {
    var render: EntityRenderer!

    override func setUp() {
        render = EntityRenderer()
    }

    func testBoxOrigin() throws {
        let chart = Chart3D {
            Box3D()
        }

        try render.renderChart(chart)

        let chartEntity = render.root.children.first
        let boxEntity = chartEntity?.children.first
        XCTAssertEqual(boxEntity?.position, .zero)
    }

    func testBoxPosition() throws {
        let chart = Chart3D {
            Box3D()
                .withPosition(.init(.one))
        }

        try render.renderChart(chart)

        let chartEntity = render.root.children.first
        let boxEntity = chartEntity?.children.first
        XCTAssertNotNil(boxEntity)
        XCTAssertEqual(boxEntity?.position, .one.flipZ)
    }
}
