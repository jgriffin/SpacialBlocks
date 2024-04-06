//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public class EntityRenderer {
    public let root = Entity()
    var renderState = RenderState()

    public init(scale: Size3D = Charts.defaultRenderScale) {
        renderState.scale = scale
    }

    public func ensureScale(_ scale: Size3D) {
        guard renderState.scale != scale else { return }

        renderState.scale = scale
        root.scale = SIMD3(scale.vector)
    }

    public func ensureScaledToFit(_ sceneBounds: Rect3D) {
        guard let bounds = renderState.chartRange, !bounds.isEmpty else { return }

        let fitScales = sceneBounds.size.vector / bounds.size.vector
        let scale = fitScales.min()
        ensureScale(.one.uniformlyScaled(by: scale))
    }
}

public extension EntityRenderer {
    internal struct RenderState {
        var scale: Size3D = .one
        var chartRange: Rect3D?

        var entityForId: [ChartContent.ContentID: Entity] = [:]
    }

    func renderChart(_ chart: Chart3D) throws {
        renderState.chartRange = chart.range

        let environment = RenderEnvironment()
        try renderContents([chart], environment, in: root)
    }

    func renderContents(
        _ contents: [EntityRepresentable],
        _ environment: RenderEnvironment,
        in parent: Entity
    ) throws {
        var existingChildren = parent.chart3DChildren

        for content in contents {
            // match or make

            let entity = try content.makeEntity()
            parent.addChild(entity)

            try content.updateEntity(entity, environment)
            entity.chart3DContent = content

            if let container = content as? ContentContaining,
               let (environment, contents) = container.contentsFor(environment),
               case let renderable = contents.compactMap({ $0 as? EntityRepresentable })
            {
                try renderContents(renderable, environment, in: entity)
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
