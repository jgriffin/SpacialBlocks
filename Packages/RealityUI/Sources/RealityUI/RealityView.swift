//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RealityView

public protocol RealityView {
    associatedtype Body: RealityView
    var body: Body { get }
}

// MARK: - layout and render

public typealias ProposedSize = Size3D

public extension RealityView {
    func sizeFor(_ proposed: ProposedSize) -> Size3D {
        if let builtIn = self as? BuiltIn {
            builtIn.sizeFor(proposed)
        } else {
            body.sizeFor(proposed)
        }
    }

    func render(_ context: RenderContext, size: Size3D) {
        if let builtIn = self as? BuiltIn {
            builtIn.render(context, size: size)
        } else {
            body.render(context, size: size)
        }
    }
}

// MARK: - BuiltIn

public protocol BuiltIn {
    typealias Body = Never

    func sizeFor(_ proposed: ProposedSize) -> Size3D
    func render(_ context: RenderContext, size: Size3D)
}

public extension RealityView where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: RealityView {
    public typealias Body = Never
}

// MARK: - Frame

public struct FixedFrame<Content: RealityView>: RealityView, BuiltIn {
    var width: Double?
    var height: Double?
    var depth: Double?
    var content: Content

    public func sizeFor(_ proposed: ProposedSize) -> Size3D {
        let childSize = content.sizeFor(
            .init(
                width: width ?? proposed.width,
                height: height ?? proposed.height,
                depth: depth ?? proposed.depth
            )
        )
        return .init(
            width: width ?? childSize.width,
            height: height ?? childSize.height,
            depth: depth ?? childSize.depth
        )
    }

    public func render(_ context: RenderContext, size: Size3D) {
        let childSize = content.sizeFor(size)
        let offset = Point3D(
            x: (size.width - childSize.width) / 2,
            y: (size.height - childSize.height) / 2,
            z: (size.depth - childSize.depth) / 2
        )
        // context.translateBy(x: x, y: y)

        content.render(context, size: childSize)
    }
}

public extension RealityView {
    func frame(width: Double? = nil, height: Double? = nil, depth: Double? = nil) -> some RealityView {
        FixedFrame(width: width, height: height, depth: depth, content: self)
    }
}
