//
// Created by John Griffin on 4/4/24
//

import Foundation
import Spatial

public struct Chart3D: EntityRepresentableContent, PositionedContent {
    public var id: ContentID
    public var bounds: Rect3D
    public var contents: [Chart3DContent]

    public init(
        id: ContentID = .init(),
        bounds: Rect3D = .init(origin: .zero, size: [0.2, 0.2, 0.2]),
        @Chart3DContentBuilder contents: () -> [any Chart3DContent]
    ) {
        self.id = id
        self.bounds = bounds
        self.contents = contents()
    }
}

public extension Chart3D {
    var anchorOffset: Vector3D {
        .init(bounds.center.vector)
    }

    func bounds(_ bounds: Rect3D) -> Chart3D {
        copyWith(self) { $0.bounds = bounds }
    }
}
