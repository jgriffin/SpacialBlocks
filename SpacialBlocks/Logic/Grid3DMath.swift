//
// Created by John Griffin on 3/28/24
//

import Foundation
import RealityKit
import simd
import Spatial

enum Grid3D {
    /// typealias for when thinking of abstract Units
    typealias Units = SIMD3<Float>
    
    struct UnitsConstraints: Equatable {
        var unitsMinBounds: BoundingBox = .init(min: .zero, max: [10, 5, 5])
        var paddingUnits: SIMD3<Float> = [1, 0, 1]
        var unitBias: UnitBias = .centerBetween
        
        var paddedBounds: BoundingBox {
            .init(
                min: unitsMinBounds.min - paddingUnits,
                max: unitsMinBounds.min + paddingUnits
            )
        }
    }
    
    enum UnitBias: Equatable {
        case centerOn,
             centerBetween,
             custom(Units)
        
        var offset: Units {
            switch self {
            case .centerOn: .zero
            case .centerBetween: [0.5, 0.5, 0.5]
            case let .custom(bias): bias
            }
        }
    }
}

extension Grid3D {
    struct UnitsFit: Equatable {
        let unitsBounds: BoundingBox
        let scale: SIMD3<Float>
        let bias: UnitBias
        
        init(unitsBounds: BoundingBox, scale: SIMD3<Float>, bias: Grid3D.UnitBias) {
            self.unitsBounds = unitsBounds
            self.scale = scale
            self.bias = bias
        }

        // MARK: - positionFor
        
        /// Take a position in grid units and returns a proper Translation position relative to the center
        /// after adjusting for the bounds origin, z flipping, and bias to end up centered on or between grid units/
        func positionForUnits(_ unitsPosition: Units, bias: UnitBias? = nil) -> SIMD3<Float> {
            let biasOffset = (bias ?? self.bias).offset
            let centerRelative = (unitsPosition + biasOffset) - unitsBounds.center
            return centerRelative * .zFlip
        }
        
        // MARK: - fitFrom
        
        init(
            from c: Grid3D.UnitsConstraints,
            sceneBounds: BoundingBox
        ) throws {
            guard !sceneBounds.isEmpty else { throw FitError.invalidSceneBounds }
            let sceneExtents = sceneBounds.extents

            guard !c.unitsMinBounds.isEmpty else { throw FitError.invalidConstrants("unitsMinBounds") }
            let paddedBounds = BoundingBox(
                min: c.unitsMinBounds.min - c.paddingUnits,
                max: c.unitsMinBounds.max + c.paddingUnits
            )
            let fitScales = sceneExtents / paddedBounds.extents
            let scale = fitScales.min()
            
            self = UnitsFit(
                unitsBounds: paddedBounds,
                scale: .one * scale,
                bias: c.unitBias
            )
        }
        
        enum FitError: Error {
            case invalidConstrants(String?),
                 invalidSceneBounds
        }
    }
}
