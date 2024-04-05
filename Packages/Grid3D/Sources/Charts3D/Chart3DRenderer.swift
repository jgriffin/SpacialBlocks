//
// Created by John Griffin on 4/4/24
//

import Foundation
import RealityKit
import Spatial

public class Chart3DRenderer {
    public let root = Entity()
    var renderState = RenderState()

    public init(scale: Size3D = .one / 2) {
        renderState.scale = scale
    }

    public func ensureScale(_ scale: Size3D) {
        guard renderState.scale != scale else { return }

        renderState.scale = scale
        root.scale = SIMD3(scale.vector)
    }

    public func ensureScaledToFit(_ sceneBounds: Rect3D) {
        guard let bounds = renderState.bounds, !bounds.isEmpty else { return }

        let fitScales = sceneBounds.size.vector / bounds.size.vector
        let scale = fitScales.min()
        ensureScale(.one.uniformlyScaled(by: scale))
    }
}

extension Chart3DRenderer {
    struct RenderState {
        var scale: Size3D = .one
        var bounds: Rect3D?

        var entityForId: [Chart3DContent.ContentID: Entity] = [:]
    }

    public func renderChart(_ chart: Chart3D) throws {
        renderState.bounds = chart.bounds

        let chartEntity = try renderEntiry(chart, in: root)

        for content in chart.contents.compactMap({ $0 as? EntityRepresentableContent }) {
            _ = try renderEntiry(content, in: chartEntity)
        }
    }

    func renderEntiry(_ content: EntityRepresentableContent, in parent: Entity) throws -> Entity {
        guard let existingEntity = renderState.entityForId[content.id],
              existingEntity.isActive
        else {
            let entity = try content.makeEntity()
            parent.addChild(entity)
            renderState.entityForId[content.id] = entity
            return entity
        }

        try content.updateEntity(existingEntity)
        return existingEntity
    }
}
