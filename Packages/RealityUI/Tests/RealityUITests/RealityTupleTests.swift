//
// Created by John Griffin on 4/18/24
//

import RealityUI
import XCTest

final class RealityTupleTests: XCTestCase {
    func testCreateTuple() {
        let tuple = RealityTuple(BoxShape(), SphereShape())
        print(tuple)
    }

    func testTupleUnpack() {
        let tuple = RealityTuple(BoxShape(), SphereShape())
        let unpacked = tuple.asContents
        print(unpacked)
        XCTAssertNotNil(unpacked.first as? BoxShape)
    }
}
