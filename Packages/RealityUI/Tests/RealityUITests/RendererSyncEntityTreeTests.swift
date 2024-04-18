import RealityKit
import RealityUI
import XCTest

final class RendererSyncEntityTreeTests: XCTestCase {
    var root: Entity!

    override func setUp() {
        root = Entity()
    }

    func testEmptyView() throws {
        let empty = EmptyContent()

        let renderTree = EnityRenderer.renderTreeFor(empty, size: .one)
        EnityRenderer.syncEntityTree(root, withRenderTree: renderTree)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(root.children.first?.children.count, 0)
    }

    func testBox() throws {
        let box = BoxShape()

        let renderTree = EnityRenderer.renderTreeFor(box, size: .one)
        EnityRenderer.syncEntityTree(root, withRenderTree: renderTree)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(root.children.first?.children.count, 0)
    }

    func testFramedBox() throws {
        let framed = BoxShape().frame(width: 2.0, height: 3.0, depth: 4.0)

        let renderTree = EnityRenderer.renderTreeFor(framed, size: .one)
        EnityRenderer.syncEntityTree(root, withRenderTree: renderTree)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(root.children.first?.children.count, 1)
        XCTAssertEqual(root.children.first?.children.first?.children.count, 0)
    }

    func testFramedSphere() throws {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0)

        let renderTree = EnityRenderer.renderTreeFor(framed, size: .one)
        EnityRenderer.syncEntityTree(root, withRenderTree: renderTree)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(root.children.first?.children.count, 1)
        XCTAssertEqual(root.children.first?.children.first?.children.count, 0)
    }

    func testFramedSphereAligned() throws {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let renderTree = EnityRenderer.renderTreeFor(framed, size: .one)
        EnityRenderer.syncEntityTree(root, withRenderTree: renderTree)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(root.children.first?.children.count, 1)
        XCTAssertEqual(root.children.first?.children.first?.children.count, 0)
    }
}
