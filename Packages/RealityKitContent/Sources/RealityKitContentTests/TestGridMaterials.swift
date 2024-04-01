//
// Created by John Griffin on 4/1/24
//

import RealityKitContent
import XCTest

class GridMaterialsTests: XCTestCase {
    func testUnitsGridDefault() async throws {
        let material = try await unitsGridShaderMaterial()
        XCTAssertEqual(material.name, "UnitGridLinesMaterial")
    }

    func testUnitsGridParameters() async throws {
        let material = try await unitsGridShaderMaterial(
            gridUnits: [0.5, 0.5, 0.5],
            lineWidth: 0.02,
            gridLineColor: .green,
            baseColor: .blue.withAlphaComponent(0.2)
        )
        XCTAssertEqual(material.name, "UnitGridLinesMaterial")
    }

    func testAbsPlasticMaterialDefault() async throws {
        let material = try await absPlasticMaterial()
        XCTAssertNotNil(material)
        XCTAssertEqual(material?.name, "ABSPlasticMaterial")
    }

    func testAbsPlasticMaterialParameters() async throws {
        let material = try await absPlasticMaterial(
            baseColorTint: .cyan
        )
        XCTAssertNotNil(material)
        XCTAssertEqual(material?.name, "ABSPlasticMaterial")
    }
}
