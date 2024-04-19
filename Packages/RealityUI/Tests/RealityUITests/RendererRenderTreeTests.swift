import RealityUI
import XCTest

final class RendererRenderTreeTests: XCTestCase {
    typealias Renderer = RealityContentRenderer

    func testEmptyView() throws {
        let empty = EmptyContent()

        let result = Renderer.renderTreeFor(empty, size: .one)

        XCTAssertTrue(result.renderer is EmptyEntityRenderer)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testBox() throws {
        let box = BoxShape()

        let result = Renderer.renderTreeFor(box, size: .one)

        XCTAssertTrue(result.renderer is MeshEntityRenderer)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testFramedBox() throws {
        let framed = BoxShape().frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let pose = (result.renderer as? PoseEntityRenderer)?.pose
        XCTAssertEqual(pose?.position, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntityRenderer)
    }

    func testFramedSphere() throws {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let pose = (result.renderer as? PoseEntityRenderer)?.pose
        XCTAssertEqual(pose?.position, .init(x: 0.0, y: 0.5, z: 1.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntityRenderer)
    }

    func testFramedSphereAligned() throws {
        let framed = SphereShape().frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let pose = (result.renderer as? PoseEntityRenderer)?.pose
        XCTAssertEqual(pose?.position, .init(x: 0.0, y: 0.0, z: 2.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntityRenderer)
    }

    func testTuple() {
        let tuple = RealityBuilder.build {
            BoxShape()
            SphereShape()
        }

        let result = Renderer.renderTreeFor(tuple, size: .one)

        XCTAssertEqual(result.children.count, 0)
    }
}
