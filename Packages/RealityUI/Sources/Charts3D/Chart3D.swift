//
// Created by John Griffin on 4/21/24
//

import RealityUI
import Spatial

public struct Chart3D<Content: ChartContent>: ChartContent {
    public var content: Content

    public init(@ChartBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some ChartContent {
        content
    }
}
