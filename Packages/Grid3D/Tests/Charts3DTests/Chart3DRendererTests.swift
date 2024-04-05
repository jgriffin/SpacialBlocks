//
// Created by John Griffin on 4/4/24
//

import RealityKit
import SpatialCharts
import XCTest

final class Chart3DRendererTests: XCTestCase {
    func testBoxOrigin() throws {
        let root = Entity()
        let render = Chart3DRenderer(root: root)
        try render.renderChart(Chart3D(contents: [
            Chart3DBox(material: .simple(color: .red, roughness: 1, isMetalic: true)),
        ]))

        let entity = root.children.first
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity?.position, .zero)
    }

    func testBoxPosition() throws {
        let root = Entity()
        let render = Chart3DRenderer(root: root)
        try render.renderChart(
            Chart3D(contents: [
                Chart3DBox(material: .simple(color: .red, roughness: 1, isMetalic: true))
                    .withPosition(.one),
            ])
        )

        let entity = root.children.first
        XCTAssertNotNil(entity)
        XCTAssertEqual(entity?.position, .one)
    }
}
