//
// Created by John Griffin on 4/4/24
//

import Combine
import Foundation
import RealityKit
import Spatial

public class EntityRenderer {
    public let root = Entity()
    var state = RenderState() {
        didSet {
            guard state != oldValue else { return }
            onStateChanged()
        }
    }

    var cancellables = Set<AnyCancellable>()

    public init(scale: Size3D = Charts.defaultRenderScale) {
        state.scale = scale
    }

    public func setSceneBounds(_ sceneBounds: Rect3D) {
        state.sceneBounds = sceneBounds
    }

    public func setScale(_ scale: Size3D) {
        guard state.scale != scale else { return }

        state.scale = scale
        root.scale = SIMD3(scale.vector)
    }

    private func onStateChanged() {
        if let scale = state.scaleThatFits(), state.scale != scale {
            setScale(scale)
        }
    }
}

public extension EntityRenderer {
    internal struct RenderState: Equatable {
        var scale: Size3D = .one
        var rootFrame: Rect3D?
        var sceneBounds: Rect3D?

        func scaleThatFits() -> Size3D? {
            guard let rootFrame, let sceneBounds, !rootFrame.isEmpty else {
                return nil
            }

            let fitScales = sceneBounds.size.vector / rootFrame.size.vector
            let scale = fitScales.min()
            return .one.uniformlyScaled(by: scale)
        }
    }

    func renderChart(_ chart: Chart3D) throws {
        let chartBounds = chart.chartBounds
        state.rootFrame = chart.frame

        let environment = RenderEnvironment().modify {
            $0.chartBounds = chartBounds
        }

        try renderContents([chart], environment, in: root)
    }

    func renderContents(
        _ contents: [ChartContent],
        _ environment: RenderEnvironment,
        in parent: Entity,
        prunePreviousChildren: Bool = true
    ) throws {
        let previousChildren = parent.chart3DChildren

        defer {
            if prunePreviousChildren {
                for pair in previousChildren {
                    parent.removeChild(pair.0)
                }
            }
        }

        for content in contents {
            guard let entityContent = content as? EntityRepresentable else {
                let representable = content.contentsFor(environment)
                if !representable.isEmpty {
                    try renderContents(
                        representable,
                        environment,
                        in: parent,
                        prunePreviousChildren: false
                    )
                }

                continue
            }

            // TODO: match existing content
            let contentEntity = try entityContent.makeEntity()
            parent.addChild(contentEntity)

            try entityContent.updateEntity(contentEntity, environment)
            contentEntity.chart3DContent = entityContent

            let representable = entityContent.contentsFor(environment)
            try renderContents(representable, environment, in: contentEntity)
        }
    }
}

extension Entity {
    var chart3DChildren: [(Entity, EntityRepresentable)] {
        children.compactMap { entity -> (Entity, EntityRepresentable)? in
            guard let content = entity.chart3DContent else { return nil }
            return (entity, content)
        }
    }
}
