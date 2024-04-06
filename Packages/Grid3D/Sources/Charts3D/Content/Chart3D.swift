//
// Created by John Griffin on 4/4/24
//

import Foundation
import Spatial

public struct Chart3D: EntityRepresentableContent, PositionedContent, Chart3DContentContainer {
    public var range: Rect3D
    public var contents: [Chart3DContent]

    public init(
        id _: ContentID = .init(),
        range: Rect3D = Defaults.chartRange,
        @Chart3DContentBuilder contents: () -> [any Chart3DContent]
    ) {
        self.range = range
        self.contents = contents()
    }
}

public extension Chart3D {
    var anchorOffset: Vector3D {
        .init(range.center.vector)
    }

    func range(_ range: Rect3D) -> Chart3D {
        copyWith(self) { $0.range = range }
    }

    func childrenForRender(_ environment: RenderEnvironment) -> (RenderEnvironment, [EntityRepresentableContent])? {
        let entityContents = contents.compactMap { $0 as? EntityRepresentableContent }
        guard !entityContents.isEmpty else {
            return nil
        }
        var environment = environment
        environment[ChartRange.self] = range

        return (environment, entityContents)
    }
}
