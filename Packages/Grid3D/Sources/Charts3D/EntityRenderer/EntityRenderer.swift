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
        var chartBounds: Rect3D?
        var sceneBounds: Rect3D?

        func scaleThatFits() -> Size3D? {
            guard let chartBounds, let sceneBounds, !chartBounds.isEmpty else {
                return nil
            }

            let fitScales = sceneBounds.size.vector / chartBounds.size.vector
            let scale = fitScales.min()
            return .one.uniformlyScaled(by: scale)
        }
    }

    func renderChart(_ chart: Chart3D) throws {
        let chartBounds = chart.containedBounds
        state.chartBounds = chartBounds

        let environment = RenderEnvironment().modify {
            $0.chartBounds = chartBounds
        }

        try renderContents([chart], environment, in: root)
    }

    func renderContents(
        _ contents: [EntityRepresentable],
        _ environment: RenderEnvironment,
        in parent: Entity
    ) throws {
        let existingChildren = parent.chart3DChildren

        for content in contents {
            // TODO: match existing content

            let entity = try content.makeEntity()
            parent.addChild(entity)

            try content.updateEntity(entity, environment)
            entity.chart3DContent = content

            let representable = content.contentsFor(environment).compactMap { $0 as? EntityRepresentable }
            if !representable.isEmpty {
                try renderContents(representable, environment, in: entity)
            }
        }

        for pair in existingChildren {
            parent.removeChild(pair.0)
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
