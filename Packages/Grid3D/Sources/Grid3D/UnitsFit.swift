//
// Created by John Griffin on 3/28/24
//

import Foundation
import RealityKit
import simd
import Spatial

/// typealias for when thinking of abstract Units
public typealias Units = SIMD3<Float>

public struct UnitsConstraints: Equatable {
    public let requiredUnits: BoundingBox
    public let paddingMin: SIMD3<Float>
    public let paddingMax: SIMD3<Float>
    public let unitBias: UnitBias

    public init(
        requiredUnits: BoundingBox,
        paddingMin: SIMD3<Float> = [0, 0, 0],
        paddingMax: SIMD3<Float> = [0, 0, 0],
        unitBias: Grid3D.UnitBias = .centerBetween
    ) {
        self.requiredUnits = requiredUnits
        self.paddingMin = paddingMin
        self.paddingMax = paddingMax
        self.unitBias = unitBias
    }

    public var paddedBounds: BoundingBox {
        .init(min: requiredUnits.min - paddingMin,
              max: requiredUnits.max + paddingMax)
    }
}

public enum UnitBias: Equatable {
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

public struct UnitsFit: Equatable {
    public let unitsBounds: BoundingBox
    public let scale: SIMD3<Float>
    public let bias: UnitBias

    public init(unitsBounds: BoundingBox, scale: SIMD3<Float>, bias: Grid3D.UnitBias) {
        self.unitsBounds = unitsBounds
        self.scale = scale
        self.bias = bias
    }

    // MARK: - positionFor

    /// Take a position in grid units and returns a proper Translation position relative to the center
    /// after adjusting for the bounds origin and bias to end up centered on or between grid units/
    public func positionForUnits(_ unitsPosition: Units, bias: UnitBias? = nil) -> SIMD3<Float> {
        let biasOffset = (bias ?? self.bias).offset
        let originAdjusted = unitsPosition - unitsBounds.min + biasOffset
        let centerRelative = originAdjusted - unitsBounds.extents / 2
        return centerRelative * .zFlip
    }

    // MARK: - fitFrom

    public init(
        from c: Grid3D.UnitsConstraints,
        sceneBounds: BoundingBox
    ) throws {
        guard !c.requiredUnits.isEmpty else { throw FitError.invalidConstrants("unitsMinBounds") }
        guard !sceneBounds.isEmpty else { throw FitError.invalidSceneBounds }

        let unitsBounds = c.paddedBounds
        let fitScales = sceneBounds.extents / unitsBounds.extents
        let scale = fitScales.min()

        self = UnitsFit(
            unitsBounds: unitsBounds,
            scale: .one * scale,
            bias: c.unitBias
        )
    }

    enum FitError: Error {
        case invalidConstrants(String?),
             invalidSceneBounds
    }
}
