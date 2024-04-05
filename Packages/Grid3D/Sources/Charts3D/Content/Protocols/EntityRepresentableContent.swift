//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol EntityRepresentableContent: Chart3DContent {
    var id: ContentID { get }

    func makeEntity() throws -> Entity

    // called by Entity.chart3DContent
    func updateEntity(_: Entity) throws
}

public extension EntityRepresentableContent {
    func makeEntity() throws -> Entity {
        let entity = Entity()
        entity.chart3DContent = self
        return entity
    }

    func updateEntity(_ entity: Entity) throws {
        try updateEntityCommon(entity)
    }

    func updateEntityCommon(_ entity: Entity) throws {
        if let model = self as? ModelRepresentableContent {
            try model.updateModelComponent(entity)
        }
        if let transformable = self as? TransformableContent {
            try transformable.updateTransformComponent(entity)
        }
    }
}
