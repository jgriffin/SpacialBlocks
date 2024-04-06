//
// Created by John Griffin on 4/4/24
//

import Charts3D
import RealityKit
import XCTest

final class Chart3DRendererTests: XCTestCase {
    func testBoxOrigin() throws {
        let chart = Chart3D {
            Chart3DBox()
        }
        let render = Chart3DRenderer()

        try render.renderChart(chart)

        let entity = render.root.children.first
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity?.position, .zero)
    }

    func testBoxPosition() throws {
        let chart = Chart3D {
            Chart3DBox()
                .withPosition(.init(.one))
        }
        let render = Chart3DRenderer()
        try render.renderChart(chart)

        let entity = render.root.children.first
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity?.position, .one)
    }
}
