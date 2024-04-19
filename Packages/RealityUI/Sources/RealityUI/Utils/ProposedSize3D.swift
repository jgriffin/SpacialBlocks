//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct ProposedSize3D {
    public var width: Double?
    public var height: Double?
    public var depth: Double?

    public init(width: Double?, height: Double?, depth: Double?) {
        self.width = width
        self.height = height
        self.depth = depth
    }
}

public extension ProposedSize3D {
    init(size: Size3D) {
        self.init(width: size.width, height: size.height, depth: size.depth)
    }

    var orMax: Size3D {
        Size3D(width: width ?? .greatestFiniteMagnitude,
               height: height ?? .greatestFiniteMagnitude,
               depth: depth ?? .greatestFiniteMagnitude)
    }

    var orDefault: Size3D {
        Size3D(width: width ?? 0.10,
               height: height ?? 0.10,
               depth: depth ?? 0.10)
    }
}
