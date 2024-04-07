//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit
import Spatial

public protocol EntityRepresentable {
    func makeEntity() throws -> Entity

    // called by Entity.chart3DContent
    func updateEntity(_: Entity, _ environment: RenderEnvironment) throws
}

public extension EntityRepresentable {
    func makeEntity() throws -> Entity {
        Entity()
    }

    func updateEntity(_ entity: Entity, _ environment: RenderEnvironment) throws {
        try updateEntityCommon(entity, environment)
    }

    func updateEntityCommon(_ entity: Entity, _: RenderEnvironment) throws {
        if let model = self as? ModelRepresentable {
            try model.updateEntityModel(entity)
        }
        if let posed = self as? Posed {
            try posed.updateEnityPose(entity)
        }
    }
}
