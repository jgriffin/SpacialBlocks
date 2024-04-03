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
    public let unitsBias: UnitBias

    public init(
        requiredUnits: BoundingBox,
        paddingMin: SIMD3<Float> = [0, 0, 0],
        paddingMax: SIMD3<Float> = [0, 0, 0],
        unitBias: Grid3D.UnitBias = .centerBetween
    ) {
        self.requiredUnits = requiredUnits
        self.paddingMin = paddingMin
        self.paddingMax = paddingMax
        unitsBias = unitBias
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
    public let unitsBias: UnitBias

    // how far the center is displaced from the grid lines
    public var centerBias: SIMD3<Float> {
        remainder(unitsBounds.center, .one)
    }

    public init(
        unitsBounds: BoundingBox,
        scale: SIMD3<Float>,
        unitsBias: Grid3D.UnitBias
    ) {
        self.unitsBounds = unitsBounds
        self.scale = scale
        self.unitsBias = unitsBias
    }

    // MARK: - positionFor

    /// Take a position in grid units and returns a proper Translation position relative to the center
    /// after adjusting for the bounds origin and bias to end up centered on or between grid units/
    public func positionForUnits(_ unitsPosition: Units, bias: UnitBias? = nil) -> SIMD3<Float> {
        print("bounds min: \(unitsBounds.min.desc) max: \(unitsBounds.max.desc) center: \(unitsBounds.center.desc)")
        let centerRelative = unitsPosition - unitsBounds.center
        let biasAdjusted = centerRelative + (bias ?? unitsBias).offset
        let position = biasAdjusted * .zFlip

        print("unitsPos: \(unitsPosition.desc) position: \(position.desc)")
        return position
    }
}

public extension UnitsFit {
    init(
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
            unitsBias: c.unitsBias
        )
    }

    enum FitError: Error {
        case invalidConstrants(String?),
             invalidSceneBounds
    }
}
