//
// Created by John Griffin on 4/18/24
//

import RealityUI
import XCTest

final class RealityBuilderTests: XCTestCase {
    func build<Content: RealityContent>(@RealityBuilder block: () -> Content) -> Content {
        block()
    }

    func testEmpty() {
        let result = build {}
        XCTAssertTrue(type(of: result) == EmptyContent.self)
    }

    func testBox() {
        let result = build { BoxShape() }
        XCTAssertTrue(type(of: result) == BoxShape.self)
    }

    func testTuple() {
        let result = build {
            BoxShape()
            BoxShape()
            SphereShape()
        }
        print(result)
//        XCTAssertTrue(result is BoxShape)
    }
}
