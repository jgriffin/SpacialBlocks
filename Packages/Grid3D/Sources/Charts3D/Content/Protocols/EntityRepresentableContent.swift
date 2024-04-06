//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol EntityRepresentableContent: Chart3DContent {
    func makeEntity() throws -> Entity

    // called by Entity.chart3DContent
    func updateEntity(_: Entity, _ environment: RenderEnvironment) throws
}

public extension EntityRepresentableContent {
    func makeEntity() throws -> Entity {
        Entity()
    }

    func updateEntity(_ entity: Entity, _ environment: RenderEnvironment) throws {
        try updateEntityCommon(entity, environment)
    }

    func updateEntityCommon(_ entity: Entity, _: RenderEnvironment) throws {
        if let model = self as? ModelRepresentableContent {
            try model.updateModelComponent(entity)
        }
        if let transformable = self as? TransformableContent {
            try transformable.updateTransformComponent(entity)
        }
    }
}
