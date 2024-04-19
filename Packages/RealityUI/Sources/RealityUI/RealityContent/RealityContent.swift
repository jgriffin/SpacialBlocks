//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RealityContent

public protocol RealityContent {
    associatedtype Body: RealityContent

    var body: Body { get }
}

// MARK: - layout and render

public extension RealityContent {
    func sizeThatFits(_ proposed: ProposedSize3D) -> Size3D {
        if let builtIn = self as? BuiltIn {
            builtIn.sizeFor(proposed)
        } else {
            body.sizeThatFits(proposed)
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

    func sizeFor(_ proposed: ProposedSize3D) -> Size3D
    func render(_ context: RenderContext, size: Size3D) -> RenderNode
}

public extension RealityContent where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: RealityContent {
    public typealias Body = Never
}

// MARK: - EmptyContent

public struct EmptyContent: RealityContent, BuiltIn {
    public init() {}

    public func sizeFor(_: ProposedSize3D) -> Size3D { .zero }

    public func render(_: RenderContext, size _: Size3D) -> RenderNode {
        .init(EmptyEntityRenderer())
    }
}