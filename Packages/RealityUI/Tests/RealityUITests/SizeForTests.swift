import RealityUI
import XCTest

final class SizeForTests: XCTestCase {
    let proposeOne = ProposedSize3D(size: .one)

    func testEmpty() {
        let empty = EmptyContent()
        let result = empty.sizeFor(proposeOne)
        XCTAssertEqual(result, .zero)
    }

    func testBox() {
        let box = BoxShape()
        let result = box.sizeFor(proposeOne)
        XCTAssertEqual(result, .one)
    }

    func testFramedBox() {
        let framed = BoxShape().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeFor(proposeOne)
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }

    func testFramedSphere() {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeFor(proposeOne)
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }
}
