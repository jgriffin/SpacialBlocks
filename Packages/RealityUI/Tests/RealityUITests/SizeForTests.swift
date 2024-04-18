import RealityUI
import XCTest

final class SizeForTests: XCTestCase {
    func testEmpty() {
        let empty = EmptyContent()
        let result = empty.sizeFor(.one)
        XCTAssertEqual(result, .zero)
    }

    func testBox() {
        let box = BoxShape()
        let result = box.sizeFor(.one)
        XCTAssertEqual(result, .one)
    }

    func testFramedBox() {
        let framed = BoxShape().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeFor(.one)
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }

    func testFramedSphere() {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeFor(.one)
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }
}
