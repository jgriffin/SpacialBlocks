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

    func render(_ context: RenderContext, size: Size3D) -> RenderNode {
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
    func render(_ context: RenderContext, size: Size3D) -> RenderNode
}

public extension RealityView where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: RealityView {
    public typealias Body = Never
}

// MARK: - EmptyView

public struct EmptyView: RealityView, BuiltIn {
    public init() {}

    public func sizeFor(_: ProposedSize) -> Size3D { .zero }

    public func render(_: RenderContext, size _: Size3D) -> RenderNode {
        .init(renderer: EmptyEntityRenderer(), children: [])
    }
}
