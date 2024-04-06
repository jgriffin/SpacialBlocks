//
// Created by John Griffin on 4/4/24
//

import Foundation
import Spatial

public struct Chart3D: EntityRepresentable, Positioned, ContentContaining {
    public var range: Rect3D
    public var contents: [ChartContent]

    public init(
        id _: ContentID = .init(),
        range: Rect3D = Charts.defaultChartRange,
        @ChartBuilder contents: () -> [any ChartContent]
    ) {
        self.range = range
        self.contents = contents()
    }
}

public extension Chart3D {
    var anchorOffset: Vector3D {
        .init(range.center.vector)
    }

    func setRange(_ range: Rect3D) -> Self {
        copy(self) { $0.range = range }
    }

    func contentsFor(_ environment: RenderEnvironment) -> (RenderEnvironment, [ChartContent])? {
        var environment = environment
        environment[ChartRange.self] = range

        return (environment, contents)
    }
}
