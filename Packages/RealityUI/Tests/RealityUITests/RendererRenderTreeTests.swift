import RealityUI
import XCTest

final class RendererRenderTreeTests: XCTestCase {
    typealias Renderer = RealityContentRenderer

    func testEmptyView() throws {
        let empty = EmptyContent()

        let result = Renderer.renderTreeFor(empty, size: .one)

        XCTAssertTrue(result.renderer is EmptyEntity)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testBox() throws {
        let box = Box()

        let result = Renderer.renderTreeFor(box, size: .one)

        XCTAssertTrue(result.renderer is MeshEntity)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testFramedBox() throws {
        let framed = Box().frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let transform = (result.renderer as? TransformEntity)?.transform
        XCTAssertEqual(transform?.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntity)
    }

    func testFramedSphere() throws {
        let framed = Sphere().frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let transform = (result.renderer as? TransformEntity)?.transform
        XCTAssertEqual(transform?.translation, .init(x: 0.0, y: 0.0, z: 0.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntity)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere().frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let result = Renderer.renderTreeFor(framed, size: .one)

        let transform = (result.renderer as? TransformEntity)?.transform
        XCTAssertEqual(transform?.translation, .init(x: 0.0, y: -0.5, z: 1.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertTrue(result.children.first?.renderer is MeshEntity)
    }
}
