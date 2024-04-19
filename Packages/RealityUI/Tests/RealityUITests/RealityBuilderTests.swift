//
// Created by John Griffin on 4/18/24
//

import RealityUI
import XCTest

final class RealityBuilderTests: XCTestCase {
    typealias Builder = RealityContentsBuilder

    func testEmpty() {
        let result = Builder.build {}
        XCTAssertEqual(result.count, 0)
    }

    func testBox() {
        let result = Builder.build { BoxShape() }
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(type(of: result.first!) == BoxShape.self)
    }

    func testMultiple() {
        let result = Builder.build {
            BoxShape()
            BoxShape()
                .frame(size: .one)
            SphereShape()
        }
        XCTAssertEqual(result.count, 3)
    }

    func testIf() {
        let no = false
        let result = Builder.build {
            BoxShape()
            if no {
                BoxShape()
            }
            if no {
                BoxShape()
                SphereShape()
            }
        }
        XCTAssertEqual(result.count, 1)
    }
}
