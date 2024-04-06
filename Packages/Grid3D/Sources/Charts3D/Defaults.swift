//
// Created by John Griffin on 4/5/24
//

import Foundation
import Spatial

public enum Defaults {
    public static let chartRange: Rect3D = .init(origin: .zero, size: [0.2, 0.2, 0.2])
    public static let boxSize: Size3D = .one * 0.1
    public static let boxUnitAnchor: Vector3D = .half
    public static let renderScale: Size3D = .one / 2
}
